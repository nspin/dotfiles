import XMonad
import XMonad.Layout
--import XMonad.Layout.Spiral

main = xmonad $ defaultConfig
    { normalBorderColor  = "#031518"
    , focusedBorderColor = "#b58900"
--    , layoutHook = netbook
    }

-- Layouts

--netbook = Full ||| spiral (6/7)

--other = netbook ||| tall ||| Mirror tall

tall = Tall 1 (3/100) (1/2)
