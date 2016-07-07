module Minibar
    ( minibar
    ) where

import Data.LOT

import Control.Monad
import Control.Variable
import System.IO
import System.Console.ANSI
import System.Console.Terminal.Size
import System.Process

minibar :: Handle -> VVar (Int -> [Chunk]) -> IO ()
minibar pty v = do
    hHideCursor pty
    actOn v $ \f -> do
        mwindow <- hSize pty
        case mwindow of
            Nothing -> error "Minibar.minibar"
            Just (Window h w) -> do
                hPutChar pty '\r'
                hPutStr pty . render $ f w
                hFlush pty
                return ()
