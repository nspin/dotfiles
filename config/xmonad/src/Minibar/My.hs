{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

module Minibar.My
    ( myMinibar
    ) where


import Minibar
import Data.LOT
import Control.Variable
import Minibar.Actors

import Control.Applicative
import Control.Monad
import Data.Attoparsec.ByteString.Char8
import Data.Function
import Data.Functor.Compose
import Data.List
import Data.Maybe
import Data.Monoid
import System.IO

import qualified Data.ByteString.Char8 as C

import XMonad.Util.Run



-- TODO logging

test :: IO ()
test = minibar stdout myMinibar

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


myMinibar :: VVar (Int -> [Chunk])
#if LAPTOP
myMinibar = laptop
#else
myMinibar = nonLaptop
#endif


laptop :: VVar (Int -> [Chunk])
laptop = (fmap (fromMaybe waiting)) . getCompose $ f
    <$> date
    <*> cpu
    <*> mem
    <*> bat
    <*> wifi
  where
    waiting width = raw "waiting"
    f date cpu mem bat wifi width = stradle width left right
      where
        right = date
        left = cpu
            <> raw " | "
            <> mem
            <> raw " | "
            <> wifi
            <> raw " | "
            <> bat


nonLaptop :: VVar (Int -> [Chunk])
nonLaptop = (fmap (fromMaybe waiting)) . getCompose $ f
    <$> date
    <*> cpu
    <*> mem
  where
    waiting width = raw "waiting"
    f date cpu mem width = stradle width left right
      where
        right = date
        left = cpu <> raw " | " <> mem


date :: Component
date = plain (raw "err") (raw . init) $ command 300 "date" ["+%a %b %_d %H:%M %Z %Y"]


wifi :: Component
wifi = parsed (raw "err") parseWifi $ command 300 "iwconfig" []

parseWifi = do
    manyTill anyChar (string "Bit Rate=")
    rate <- double
    unit <- char ' ' *> manyTill anyChar (char ' ')
    manyTill anyChar (string "Link Quality=")
    qual <- on (/) fromIntegral <$> (decimal <* char '/') <*> (decimal :: Parser Int)
    return . raw $ "Wifi: " ++ show rate ++ " " ++ unit ++ " " ++ show (round (100 * qual)) ++ "%"


bat :: Component
bat = parsed (raw "err") parseBat $ command 300 "upower" ["--dump"]

parseBat = do
    manyTill (manyTill anyChar endOfLine) (string "Device: " >> toBat >> manyTill anyChar endOfLine)
    manyTill anyChar (string "state:")
    skipSpace
    state <- manyTill anyChar endOfLine
    manyTill anyChar (string "percentage:")
    skipSpace
    percentage <- manyTill anyChar endOfLine
    return . raw $ "Battery: " ++ state ++ " " ++ percentage
  where
    toBat = string "BAT" <|> (satisfy (not . isSpace) >> toBat)


mem :: Component
mem = parsed (raw "err") parseMem $ command 300 "free" ["-m"]

parseMem = do
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
    return . raw $ "Mem: "
                ++ show used ++ "/" ++ show total
                ++ ", Swap: "
                ++ show usedS ++ "/" ++ show totalS


cpu :: Component
cpu = parsed (raw "err") parseCpu $ command 300 "mpstat" []

parseCpu = do
    manyTill anyChar (string "all")
    skipSpace
    d <- double
    return . raw $ "Cpu: " ++ show d ++ "%"
