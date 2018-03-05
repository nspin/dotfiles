{-# LANGUAGE RecordWildCards #-}


module XMonad.Me.PopUp
    ( doPopUp
    ) where


import           XMonad.Me.Terminal

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

doPopUp :: Integer -> Integer -> ManageHook
doPopUp x y = Query (ReaderT go)
  where
    go w = do
        sh <- withDisplay $ \d -> io (getWMNormalHints d w)
        case units2DToDimensions sh x y of
            Nothing -> error "XMonad.Util.PopUp.doPopUp"
            Just (xd, yd) -> do
                bw <- asks $ borderWidth . config
                sr <- gets $ screenRect . W.screenDetail . W.current . windowset
                let totalBorder = fromIntegral (2 * bw)
                    rr = rationalRectIn (xd + totalBorder) (yd + totalBorder) sr
                return . Endo $ W.float w rr
