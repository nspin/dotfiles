{-# optioNS -fno-warn-missing-signatures #-}
{-# LANGUAGE RecordWildCards #-}

-- This file is an altered version of XMonad.Config

module Main where

import           XMonad
import           XMonad.Core
import           XMonad.Layout
import           XMonad.Operations
import           XMonad.ManageHook
import qualified XMonad.StackSet as W

-- Contrib
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Util.Run

import           Data.Bits ((.|.))
import           Data.Monoid
import qualified Data.Map as M
import           System.IO
import           System.Exit
import           Graphics.X11.Xlib
import           Graphics.X11.Xlib.Extras

dmenu :: String
-- dmenu = "dmenu_run -fn \"-*-dejavu sans mono-*-*-*-*-*-*-*-*-*-*-*-*\""
dmenu = "dmenu_run -fn \"-*-*-*-*-*-*-18-*-*-*-*-*-*-*\""
-- dmenu = "dmenu_run -fn \"-*-fixed-medium-*-*-*-18-*-*-*-*-*-*-*\""
-- dmenu = "dmenu_run -fn \"-*-*-medium-r-*-*-18-*-*-*-*-*-*-*\""
-- dmenu = "dmenu_run"

main :: IO ()
main = do
    xmproc <- spawnPipe "/run/current-system/sw/bin/xmobar"

    let myLogHook = dynamicLogWithPP xmobarPP
           { ppOutput = hPutStrLn xmproc  
           , ppTitle = xmobarColor "#657b83" "" . shorten 100   
           , ppCurrent = xmobarColor "#c0c0c0" "" . wrap "" ""
           , ppSep     = xmobarColor "#c0c0c0" "" " | "
           , ppUrgent  = xmobarColor "#ff69b4" ""
           , ppLayout = const "" -- to disable the layout info on xmobar  
           } 

        myConfig = XConfig
            {
            -- Simple

              borderWidth        = 1
            , terminal           = "xterm"
            , modMask            = mod3Mask
            , startupHook        = return ()
            , manageHook         = manageDocks
            , handleEventHook    = const $ return (All True)
            , focusFollowsMouse  = True
            , clickJustFocuses   = True

            -- More complex

            -- , normalBorderColor = "#002b36"
            -- , focusedBorderColor = "#657b83"

            , normalBorderColor  = darkish
            , focusedBorderColor = darkish

            , workspaces         = map fst stuff
            , layoutHook         = avoidStruts $ vbox

            , logHook            = myLogHook

            , keys               = myKeys
            , mouseBindings      = myMouseBindings
            }

    xmonad myConfig

stuff :: [(WorkspaceId, KeySym)]
stuff = [ ("0", xK_0)
        , ("9", xK_9)
        , ("8", xK_8)
        , ("7", xK_7)
        , ("6", xK_6)
        ]

darkish :: String
darkish = "#031518"

vbox = Full ||| tiled ||| Mirror tiled
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys (XConfig {..}) = M.fromList $

    -- [ ((modMask, xK_m), spawn terminal)
    -- ]
    -- ++
    -- mod-N %! Switch to workspace N
    -- mod-shift-N %! Move client to workspace N
    [ ((m .|. modMask, k), windows $ f i)
    | (i, k) <- stuff
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]

    -- from XMonad.Config
    ++
    -- launching and killing programs
    [ ((modMask,               xK_Return), spawn terminal) -- %! Launch terminal
    , ((modMask,               xK_p     ), spawn dmenu) -- %! Launch dmenu
    , ((modMask .|. shiftMask, xK_p     ), spawn "gmrun") -- %! Launch gmrun
    , ((modMask .|. shiftMask, xK_c     ), kill) -- %! Close the focused window

    , ((modMask,               xK_space ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
    , ((modMask .|. shiftMask, xK_space ), setLayout layoutHook) -- %!  Reset the layouts on the current workspace to default

    , ((modMask,               xK_n     ), refresh) -- %! Resize viewed windows to the correct size

    -- move focus up or down the window stack
    , ((modMask,               xK_Tab   ), windows W.focusDown) -- %! Move focus to the next window
    , ((modMask .|. shiftMask, xK_Tab   ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((modMask,               xK_j     ), windows W.focusDown) -- %! Move focus to the next window
    , ((modMask,               xK_k     ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((modMask,               xK_m     ), windows W.focusMaster  ) -- %! Move focus to the master window

    -- modifying the window order
    , ((modMask .|. shiftMask, xK_Return), windows W.swapMaster) -- %! Swap the focused window and the master window
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window

    -- resizing the master/slave ratio
    , ((modMask,               xK_h     ), sendMessage Shrink) -- %! Shrink the master area
    , ((modMask,               xK_l     ), sendMessage Expand) -- %! Expand the master area

    -- floating layer support
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink) -- %! Push window back into tiling

    -- increase or decrease number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1)) -- %! Increment the number of windows in the master area
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area

    -- quit, or restart
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)) -- %! Quit xmonad
    , ((modMask              , xK_q     ), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") -- %! Restart xmonad
    ]
    ++
    -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
    [ ((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
    | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ]

-- | Mouse bindings: default actions bound to mouse events
myMouseBindings :: XConfig Layout -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings (XConfig {..}) = M.fromList
    -- mod-button1 %! Set the window to floating mode and move by dragging
    [ ((modMask, button1), \w -> focus w >> mouseMoveWindow w
                                          >> windows W.shiftMaster)
    -- mod-button2 %! Raise the window to the top of the stack
    , ((modMask, button2), windows . (W.shiftMaster .) . W.focusWindow)
    -- mod-button3 %! Set the window to floating mode and resize by dragging
    , ((modMask, button3), \w -> focus w >> mouseResizeWindow w
                                         >> windows W.shiftMaster)
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]
