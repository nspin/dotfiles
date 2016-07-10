module Minibar.My
    ( myMinibar
    ) where


import Minibar
import Data.LOT

import Control.Variable
import Minibar.Actors
import Data.Function
import Data.List


myMinibar :: VVar (Int -> [Chunk])
myMinibar = f <$> command 1000 "date" <*> command 300 "date"

f :: Late (Maybe String) -> Late (Maybe String) -> (Int -> [Chunk])
f x y width = stradle width [Chunk [] $ defMess init x] [Chunk [] $ defMess init y]

maybes :: a -> a -> (b -> a) -> Late (Maybe b) -> a
maybes a0 a1 f = maybe a0 (maybe a1 f)
-- maybes = (.) `on` maybe

defMess :: (a -> String) -> Late (Maybe a) -> String
defMess = maybes "NIL" "ERR"
