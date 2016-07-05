module Test where

import Control.Variable
import Minibar.Actors
import Minibar.My
import Data.LOT

import Data.Function
import Data.List

mbar :: IO ()
mbar = actOn myMinibar $ \f -> do
    putStrLn $ render (f 100)
