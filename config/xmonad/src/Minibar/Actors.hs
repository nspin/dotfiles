module Minibar.Actors
    ( command
    , handle
    ) where

import XMonad.Util.Run
import Control.Variable
import Control.Concurrent
import Control.Monad
import System.IO
import System.Exit
-- import System.Process

-- go :: FilePath -> [String] -> IO (ExitCode, String, String)
-- go cmd args = do
--     (pin, pout, perr, ph) <- runInteractiveProcess

command :: Int -> String -> VVar (Maybe (Maybe String))
command delay cmd = actor $ \sink -> forever $ do
    out <- runProcessWithInput "sh" ["-c", cmd] ""
    let code = ExitSuccess
    -- (code, out, _) <- go "sh" ["-c", cmd]
    case code of
        ExitSuccess -> sink $ Just out
        ExitFailure _ -> sink Nothing
    threadDelay $ 1000 * delay

handle :: Handle -> VVar (Maybe (Maybe String))
handle hndl = undefined
