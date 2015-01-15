import XMonad

main = xmonad $ defaultConfig
    { normalBorderColor  = "#031518"
    , focusedBorderColor = "#031518" --"#b58900"
    , focusFollowsMouse  = False
    }
