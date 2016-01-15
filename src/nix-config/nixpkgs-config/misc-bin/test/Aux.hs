{-# LANGUAGE CPP #-}

module Aux where

wat :: IO ()
wat = putStrLn _NAME >> putStrLn _OTHER
