{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_xmonad_config (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/nick/.cabal/bin"
libdir     = "/home/nick/.cabal/lib/x86_64-linux-ghc-8.0.1/xmonad-config-0.1.0.0-D88RN5HsvqILYB9LFa3361"
dynlibdir  = "/home/nick/.cabal/lib/x86_64-linux-ghc-8.0.1"
datadir    = "/home/nick/.cabal/share/x86_64-linux-ghc-8.0.1/xmonad-config-0.1.0.0"
libexecdir = "/home/nick/.cabal/libexec"
sysconfdir = "/home/nick/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "xmonad_config_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "xmonad_config_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "xmonad_config_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "xmonad_config_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "xmonad_config_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "xmonad_config_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
