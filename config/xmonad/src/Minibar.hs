module Minibar
    ( minibar
    ) where

import Data.LOT

import Control.Monad
import Control.Variable
import System.Posix.IO
import System.Posix.Types
import System.Console.ANSI
import System.Console.Terminal.Size

minibar :: Fd -> VVar (Int -> [Chunk]) -> IO ()
minibar pty v = do
    fdWrite pty hideCursorCode
    actOn v $ \f -> do
        mwindow <- fdSize pty
        case mwindow of
            Nothing -> error "Minibar.minibar"
            Just (Window h w) -> void $ do
                fdWrite pty clearScreenCode
                fdWrite pty . render $ f w
