{-# LANGUAGE RecordWildCards #-}

import qualified Data.Map as M

import           XMonad
import           XMonad.Layout
import           XMonad.Layout.Spiral
import qualified XMonad.StackSet as W

main = xmonad $ defaultConfig
    { modMask            = mod3Mask -- See Xmodmap
    , keys               = myKeys
    , layoutHook         = vbox
    , startupHook        = myStartupHook
    , normalBorderColor  = darkish
    , focusedBorderColor = darkish
    }

-- Colors

darkish = "#031518"
orangish = "#b58900"

-- Layouts

netbook = Full ||| spiral (6/7)

vbox = Full ||| tall ||| Mirror tall
  where tall = Tall 1 (3/100) (1/2)

-- Keys

myKeys cfg = extraKeys cfg `M.union` keys defaultConfig cfg

extraKeys XConfig{..} = M.fromList
    [ ((modMask, xK_backslash), windows W.focusDown)
    ]

myStartupHook = spawn "xterm"
