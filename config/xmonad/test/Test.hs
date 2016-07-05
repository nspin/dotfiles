module Test where

import Control.Variable
import Minibar.Actors
import Minibar.My
import Minibar
import XMonad.Util.Terminal
import Data.LOT

import Control.Concurrent
import Data.Function
import Data.List

mbar :: IO ()
mbar = actOn myMinibar $ \f -> do
    putStrLn $ render (f 100)

status = do

    pty <- spawnPty ["-title", "statusbar"]

    -- minibar pty myMinibar
    forkIO $ minibar pty myMinibar
    -- threadDelay 5000000
