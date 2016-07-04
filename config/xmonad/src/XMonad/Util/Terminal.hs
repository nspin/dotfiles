{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RecordWildCards #-}

module XMonad.Util.Terminal
    ( spawnPty
    , unitsToDimension
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

spawnPty :: [String] -> IO Fd
spawnPty args = do
    (master, slave) <- openPseudoTerminal
    slaveName <- getSlaveTerminalName master
    let ptyArg = "-S" ++ slaveName ++ "/" ++ show master
    spawnProcess "xterm" (ptyArg:args)
    return slave

unitsToDimension :: SizeHints -> Direction2D -> Integer -> Maybe Dimension
unitsToDimension sh dir units = do
     (minX, minY) <- sh_min_size sh
     (incX, incY) <- sh_resize_inc sh
     return $ let x = minX + fromIntegral units * incX
                  y = minY + fromIntegral units * incY
              in case dir of
                    U -> y
                    D -> y
                    L -> x
                    R -> x

