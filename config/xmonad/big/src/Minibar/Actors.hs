module Minibar.Actors
    ( command
    , handle
    ) where

import XMonad.Util.Run
import Minibar.Variable
import Control.Concurrent
import Control.Monad
import System.IO
import System.Exit
-- import System.Process

-- go :: FilePath -> [String] -> IO (ExitCode, String, String)
-- go cmd args = do
--     (pin, pout, perr, ph) <- runInteractiveProcess

command :: Int -> String -> [String] -> VVar (Maybe (Maybe String))
command delay cmd args = actor $ \sink -> forever $ do
    out <- runProcessWithInput cmd args ""
    let code = ExitSuccess
    -- (code, out, _) <- go "sh" ["-c", cmd]
    case code of
        ExitSuccess -> sink $ Just out
        ExitFailure _ -> sink Nothing
    threadDelay $ 1000 * delay

handle :: Handle -> VVar (Maybe (Maybe String))
handle hndl = undefined
