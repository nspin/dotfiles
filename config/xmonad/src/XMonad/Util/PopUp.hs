{-# LANGUAGE RecordWildCards #-}


module XMonad.Util.PopUp
    ( mkPopUp
    ) where


import           XMonad.Util.Terminal

import           XMonad
import qualified XMonad.StackSet as W

import           Control.Monad.Reader
import           Data.Ratio
import           Data.Monoid


rationalRectIn :: Dimension -> Dimension -> Rectangle -> W.RationalRect
rationalRectIn x y Rectangle{..} = W.RationalRect ((1 - w) / 2) ((1 - h) / 2) w h
  where
    w = fi x % fi rect_width
    h = fi y % fi rect_width
    fi z = fromIntegral z

mkPopUp :: Integer -> Integer -> ManageHook
mkPopUp x y = Query (ReaderT go)
  where
    go w = do
        sh <- withDisplay $ \d -> io (getWMNormalHints d w)
        case units2DToDimensions sh x y of
            Nothing -> error "XMonad.Util.PopUp.mkPopUp"
            Just (xd, yd) -> do
                nb <- asks normalBorder
                bw <- asks $ borderWidth . config
                withDisplay $ \d -> io $ do
                    setWindowBorderWidth d w bw
                    setWindowBorder d w nb
                sr <- gets $ screenRect . W.screenDetail . W.current . windowset
                let totalBorder = fromIntegral (2 * bw)
                    rr = rationalRectIn (xd + totalBorder) (yd + totalBorder) sr
                return . Endo $ W.float w rr

