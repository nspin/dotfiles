{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module XMonad.Me.Space
    ( Space(..)
    , Trivial(..)
    ) where

import           XMonad
import qualified XMonad.StackSet as W

data Trivial a = Trivial deriving (Read, Show)

instance LayoutClass Trivial a where
    pureLayout _ rect (W.Stack m ls rs) = [(a, Rectangle 100 100 100 100) | a <- ls ++ [m] ++ rs]

data Space layout a = Space
    { gap   :: Integer
    , inner :: layout a
    } deriving (Read, Show)

instance LayoutClass layout a => LayoutClass (Space layout) a where

    runLayout (W.Workspace i (Space gap inner) ms) rect = do
        (rects, new) <- runLayout (W.Workspace i inner ms) rect
        return (gapify rects, fmap (Space gap) new)
      where
        gapify = map $ \(a, r) -> (a, smallify r)
        smallify (Rectangle x y w h) = Rectangle (x + fromIntegral gap)
                                                 (y + fromIntegral gap)
                                                 (w - fromIntegral gap)
                                                 (h - fromIntegral gap)

    handleMessage (Space gap inner) = fmap (fmap (Space gap)) . handleMessage inner
