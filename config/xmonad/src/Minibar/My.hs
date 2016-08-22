{-# LANGUAGE OverloadedStrings #-}

module Minibar.My
    ( myMinibar
    ) where


import Minibar
import Data.LOT

import Control.Applicative
import Control.Monad
import Control.Variable
import Minibar.Actors
import Data.Function
import Data.List
import qualified Data.ByteString.Char8 as C
import System.IO

import XMonad.Util.Run

import Data.Attoparsec.ByteString.Char8


-- TODO logging

test :: IO ()
test = minibar stdout myMinibar

myMinibar :: VVar (Int -> [Chunk])
myMinibar = f <$> wifi <*> bat <*> mem <*> datetime
  where
    f w b m dt width = stradle width [ Chunk [] $ defMess init w
                                     , Chunk [] " | "
                                     , Chunk [] $ defMess init b
                                     , Chunk [] " | "
                                     , Chunk [] $ defMess init m
                                     ]
                                     [ Chunk [] $ defMess init dt
                                     ]
-- myMinibar = f <$> command 1000 "date" <*> command 300 "date"

datetime = command 300 "date" ["+%a %b %_d %H:%M %Z %Y"]

wifi = fmap (join . fmap (fmap f)) $ command 300 "iwconfig" []
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


bat = fmap (join . fmap (fmap f)) $ command 300 "upower" ["--dump"]
  where
    f str = case parseOnly batParser (C.pack str) of
        Left err -> Nothing
        Right (state, percentage) -> Just $ "Battery: " ++ state ++ " " ++ percentage ++ "%"

batTest = (parseOnly batParser . C.pack) <$> (runProcessWithInput "upower" ["--dump"] "" :: IO String)

batParser = do
    manyTill (manyTill anyChar endOfLine) (string "Device: " >> toBat >> manyTill anyChar endOfLine)
    manyTill anyChar (string "state:")
    skipSpace
    state <- manyTill anyChar endOfLine
    manyTill anyChar (string "percentage:")
    skipSpace
    percentage <- manyTill anyChar endOfLine
    return (state, percentage)
  where
    toBat = string "BAT" <|> (satisfy (not . isSpace) >> toBat)


mem = fmap (join . fmap (fmap f)) $ command 300 "free" ["-m"]
  where
    f str = case parseOnly memParser (C.pack str) of
        Left err -> Nothing
        Right (used, total, usedS, totalS) -> Just $ "Mem: " ++ show used ++ "/" ++ show total ++ ", Swap: " ++ show usedS ++ "/" ++ show totalS ++ " "

memTest = (parseOnly memParser . C.pack) <$> (runProcessWithInput "free" ["-m"] "" :: IO String)

memParser = do
    manyTill anyChar (string "Mem:")
    skipSpace
    total <- decimal
    skipSpace
    used <- decimal
    manyTill anyChar (string "Swap:")
    skipSpace
    totalS <- decimal
    skipSpace
    usedS <- decimal
    return (used, total, usedS, totalS)


f :: Late (Maybe String) -> Late (Maybe String) -> (Int -> [Chunk])
f x y width = stradle width [Chunk [] $ defMess init x] [Chunk [] $ defMess init y]

maybes :: a -> a -> (b -> a) -> Late (Maybe b) -> a
maybes a0 a1 f = maybe a0 (maybe a1 f)
-- maybes = (.) `on` maybe

defMess :: (a -> String) -> Late (Maybe a) -> String
defMess = maybes "NIL" "ERR"
