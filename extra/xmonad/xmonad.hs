import XMonad
import XMonad.Layout
import XMonad.Layout.Spiral

main = xmonad $ defaultConfig
    { normalBorderColor  = darkish
    , focusedBorderColor = darkish
    , layoutHook = other
    }

darkish = "#031518"
orangish = "#b58900"

-- Layouts

netbook = Full ||| spiral (6/7)

other = netbook ||| tall ||| Mirror tall

tall = Tall 1 (3/100) (1/2)
