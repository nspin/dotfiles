module Test where

import Minibar
import Minibar.Variable
import Minibar.Actors
import Minibar.Terminal
import Minibar.Components
import Minibar.LOT

import Control.Concurrent
import Data.Function
import Data.List
import Data.Monoid
import Data.Maybe
import Data.Functor.Compose


foo :: VVar (Int -> [Chunk])
foo = (fmap (fromMaybe waiting)) . getCompose $ f
    <$> date <*> cpu <*> mem <*> bat <*> wifi
  where
    waiting width = raw "waiting"
    f date cpu mem bat wifi width = stradle width left right
      where
        right = date
        left = cpu <> raw " | " <> mem <> raw " | " <> wifi <> raw " | " <> bat

mbar :: IO ()
mbar = actOn foo $ \f -> do
    putStrLn $ render (f 100)

status = do

    pty <- spawnPty ["-title", "statusbar"]

    -- minibar pty myMinibar
    forkIO $ minibar pty foo
    -- threadDelay 5000000
