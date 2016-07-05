module Data.LOT
    ( render
    , leftpad
    , rightpad
    , printables
    , stradle
    , raw
    , Chunk(..)
    ) where

import Data.Monoid
import Data.Text (Text)
import System.Console.ANSI
import Control.Applicative
import qualified Data.Text as T

-- data These a b = This a | That b | These a b

-- data CenterStrategy = Absolute | Relative

-- data LOT = Center CenterStrategy [Fixed] (Maybe [Fixed]) (Maybe [Fixed])
--          | NoCenter (These [Fixed] [Fixed])

-- data Fixed = Raw Text
--            | Box Int LOT

data Chunk = Chunk { sgr :: [SGR]
                   , contents :: String
                   }

printables :: [Chunk] -> Int
printables = sum . map (length . contents)

render :: [Chunk] -> String
render = concatMap $ liftA2 (\a b -> setSGRCode [] ++ a ++ b) (setSGRCode . sgr) contents

leftpad, rightpad :: Int -> String -> String
leftpad  n s =      replicate (max 0 (n - length s)) ' ' ++ s
rightpad n s = s ++ replicate (max 0 (n - length s)) ' '

stradle :: Int -> [Chunk] -> [Chunk] -> [Chunk]
stradle width c0 c1 = c0 <> [Chunk [] (replicate n ' ')] <> c1
  where n = width - (printables c0 + printables c1)

raw :: String -> [Chunk]
raw = (:[]) . Chunk []
