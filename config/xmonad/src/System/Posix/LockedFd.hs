module System.Posix.LockedFd
    ( LockedFd
    , newLockedFd
    , withLockedFd
    ) where

import Control.Concurrent.MVar
import System.Posix.Types

data LockedFd = LockedFd Fd (MVar ())

newLockedFd :: Fd -> IO LockedFd
newLockedFd fd = LockedFd fd <$> newMVar ()

withLockedFd :: LockedFd -> (Fd -> IO a) -> IO a
withLockedFd (LockedFd fd mvar) f = takeMVar mvar *> f fd <* putMVar mvar ()
