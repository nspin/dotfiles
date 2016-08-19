{-# LANGUAGE OverloadedStrings #-}

module Minibar.My
    ( myMinibar
    ) where


import Minibar
import Data.LOT

import Control.Monad
import Control.Variable
import Minibar.Actors
import Data.Function
import Data.List
import qualified Data.ByteString.Char8 as C

import XMonad.Util.Run

import Data.Attoparsec.Char8


-- TODO logging

myMinibar :: VVar (Int -> [Chunk])
myMinibar = f <$> wifi <*> datetime
  where
    f w dt width = stradle width [Chunk [] $ defMess init w] [Chunk [] $ defMess init dt]
-- myMinibar = f <$> command 1000 "date" <*> command 300 "date"

datetime = command 300 "date '+%a %b %_d %H:%M %Z %Y'"

wifi = fmap (join . fmap (fmap f)) $ command 300 "iwconfig"
  where
    f str = case parseOnly wifiParser (C.pack str) of
        Left err -> Nothing
        Right (rate, unit, qual) -> Just $ "Wifi: " ++ show rate ++ " " ++ unit ++ " " ++ show (round $ qual * 100) ++ "%"

wifiTest = (parseOnly wifiParser . C.pack) <$> (runProcessWithInput "sh" ["-c", "iwconfig"] "" :: IO String)

wifiParser = do
    manyTill anyChar (string "Bit Rate=")
    rate <- double
    unit <- char ' ' *> manyTill anyChar (char ' ')
    manyTill anyChar (string "Link Quality=")
    qual <- on (/) fromIntegral <$> (decimal <* char '/') <*> (decimal :: Parser Int)
    return (rate, unit, qual)


f :: Late (Maybe String) -> Late (Maybe String) -> (Int -> [Chunk])
f x y width = stradle width [Chunk [] $ defMess init x] [Chunk [] $ defMess init y]

maybes :: a -> a -> (b -> a) -> Late (Maybe b) -> a
maybes a0 a1 f = maybe a0 (maybe a1 f)
-- maybes = (.) `on` maybe

defMess :: (a -> String) -> Late (Maybe a) -> String
defMess = maybes "NIL" "ERR"
