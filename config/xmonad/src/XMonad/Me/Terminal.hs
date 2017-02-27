module XMonad.Me.Terminal
    ( spawnPty
    , Direction2D(..)
    , unitsToDimension
    , units2DToDimensions
    ) where


import           Graphics.X11.Xinerama
import           Graphics.X11.Xlib.Extras
import           Graphics.X11.Xlib.Types

import           System.IO
import           System.Posix.IO
import           System.Posix.Terminal
import           System.Posix.Types
import           System.Process


spawnPty :: [String] -> IO Handle
spawnPty args = do
    (master, slave) <- openPseudoTerminal
    spawnProcess "urxvt" ("-pty-fd" : show slave : args)
    h <- fdToHandle slave
    hSetBuffering h NoBuffering
    return h


data Direction2D = U | D | L | R
    deriving (Eq, Read, Show)

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

units2DToDimensions :: SizeHints -> Integer -> Integer -> Maybe (Dimension, Dimension)
units2DToDimensions sh dir units = do
     (minX, minY) <- sh_min_size sh
     (incX, incY) <- sh_resize_inc sh
     return (minX + fromIntegral units * incX, minY + fromIntegral units * incY)
