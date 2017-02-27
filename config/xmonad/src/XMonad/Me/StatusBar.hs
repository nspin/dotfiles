{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RecordWildCards #-}


module XMonad.Me.StatusBar
    ( FakeStrut(..)
    , doStatusBar
    ) where


import           XMonad.Me.Terminal

import           XMonad
import qualified XMonad.StackSet as W

import           Control.Monad.Reader
import           Data.List
import           Data.Monoid


currentScreen :: X ScreenId
currentScreen = gets $ W.screen . W.current . windowset

splitRectangle :: Direction2D -> Dimension -> Rectangle -> (Rectangle, Rectangle)
splitRectangle dir dim Rectangle{..} = case dir of
    U -> ( Rectangle rect_x rect_y rect_width dim 
         , Rectangle rect_x (rect_y + idim) rect_width (rect_height - dim)
         )
    D -> ( Rectangle rect_x (rect_y + fromIntegral rect_height - idim) rect_width dim
         , Rectangle rect_x rect_y rect_width (rect_height - dim)
         )
    L -> ( Rectangle rect_x rect_y dim rect_height
         , Rectangle (rect_x + idim) rect_y (rect_width - dim) rect_height
         )
    R -> ( Rectangle (rect_x + fromIntegral rect_height - idim) rect_y dim rect_height
         , Rectangle rect_x rect_y (rect_width - dim) rect_height
         )
  where
    idim = fromIntegral dim

data FakeStrut l a = FakeStrut ScreenId Direction2D Dimension (l a)
    deriving (Show, Read)

instance LayoutClass l a => LayoutClass (FakeStrut l) a where

    runLayout (W.Workspace i (FakeStrut sid dir dim l) ms) r = do
        csid <- currentScreen
        let r' = if csid == sid then snd (splitRectangle dir dim r) else r
        (fmap . fmap . fmap) (FakeStrut sid dir dim) $ runLayout (W.Workspace i l ms) r'

    handleMessage (FakeStrut sid dir dim l) = fmap (fmap (FakeStrut sid dir dim)) . handleMessage l

    description (FakeStrut sid dir dim l) = intercalate " "
        [ "FakeStrut"
        , show sid
        , show dir
        , description l
        ]

doStatusBar :: String -> Direction2D -> Integer -> ManageHook
doStatusBar border dir units = Query (ReaderT go) <+> doIgnore
  where
    go w = do
        sh <- withDisplay $ \d -> io (getWMNormalHints d w)
        case unitsToDimension sh dir units of
            Nothing -> error "XMonad.Util.StatusBar.doStatusBar"
            Just dim -> do
                mpix <- withDisplay $ \d -> io (initColor d border)
                case mpix of
                    Nothing -> error "XMonad.Util.StatusBar.doStatusBar"
                    Just pix -> do
                        bw <- asks $ borderWidth . config
                        withDisplay $ \d -> io $ do
                            setWindowBorderWidth d w bw
                            setWindowBorder d w pix
                        sr <- gets $ screenRect . W.screenDetail . W.current . windowset
                        let fullDim = (dim + fromIntegral (2 * bw))
                            (statusBarRect, _) = splitRectangle dir fullDim sr
                        tileWindow w statusBarRect
                        sid <- currentScreen
                        return $ Endo . W.mapLayout $ \(Layout a) -> Layout (FakeStrut sid dir fullDim a)
