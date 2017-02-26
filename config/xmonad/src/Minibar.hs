module Minibar
    ( minibar
    , Component
    , parsed
    , plain
    ) where


import Control.Variable
import Data.LOT
import XMonad.Util.Run

import Control.Monad
import Data.Attoparsec.ByteString.Char8
import Data.Functor.Compose
import Data.Maybe
import System.IO
import System.Console.ANSI
import System.Console.Terminal.Size
import System.Process

import qualified Data.ByteString.Char8 as C


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


-- TODO logging

type Component = Compose VVar Maybe [Chunk]

parsed :: [Chunk] -> Parser [Chunk] -> VVar (Maybe (Maybe String)) -> Component
parsed onErr parser =
    fmap ( fromMaybe onErr
         . (=<<) ( either (const Nothing) Just
                 . parseOnly parser
                 . C.pack
                 )
         ) . Compose

plain :: [Chunk] -> (String -> [Chunk]) -> VVar (Maybe (Maybe String)) -> Component
plain onErr format = fmap (maybe onErr format) . Compose
