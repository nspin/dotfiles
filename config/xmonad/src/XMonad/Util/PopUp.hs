{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RecordWildCards #-}

module XMonad.Util.PopUp
    ( mkPopUp
    ) where

import           XMonad
import qualified XMonad.StackSet as W
import           Data.List
import           Data.Monoid

import           System.Posix.Types
import           System.Posix.IO
import           System.Posix.Terminal
import           System.Process

import           Graphics.X11.Xinerama
import           Graphics.X11.Xlib.Types
import           XMonad.Layout.Gaps

import           Data.Word
import           Control.Monad.Reader

mkPopUp :: Integer -> Integer -> ManageHook
mkPopUp dir units = Query (ReaderT go)
  where
    go :: Window -> X (Endo WindowSet)
    go = undefined
  --   go w = do
  --       sh <- withDisplay $ \d -> io (getWMNormalHints d w)
  --       case unitsToDimension sh dir units of
  --           Nothing -> error "XMonad.Util.mkStatusBar"
  --           Just dim -> do
  --               nb <- asks normalBorder
  --               bw <- asks $ borderWidth . config
  --               withDisplay $ \d -> io $ do
  --                   setWindowBorderWidth d w bw
  --                   setWindowBorder d w nb
  --               sr <- gets $ screenRect . W.screenDetail . W.current . windowset
  --               let fullDim = (dim + fromIntegral (2 * bw))
  --                   (statusBarRect, _) = splitRectangle dir fullDim sr
  --               tileWindow w statusBarRect
  --               sid <- currentScreen
  --               return $ Endo . W.mapLayout $ \(Layout a) -> Layout (FakeStrut sid dir fullDim a)
