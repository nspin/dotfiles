{-# LANGUAGE RecordWildCards #-}

module Main where

import           XMonad
import           XMonad.Actions.CycleWS
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.SetWMName
import qualified XMonad.StackSet as W
import           XMonad.Util.Run
import           XMonad.Util.WorkspaceCompare

import qualified Data.Map as M
import           System.Exit
import           System.IO


main :: IO ()
main = do

    hSetBuffering stdout NoBuffering
    hSetBuffering stderr NoBuffering

    xmobar <- spawnPipe "xmobar"

    let pp = PP
            { ppCurrent = xmobarColor orange base03 . pad
            , ppVisible = xmobarColor green base03 . pad
            , ppHidden = xmobarColor green "" . pad
            , ppHiddenNoWindows = pad
            , ppUrgent = xmobarColor green red . pad
            , ppSep = ""
            , ppWsSep = ""
            , ppTitle = const ""
            , ppTitleSanitize = const ""
            , ppLayout = const ""
            , ppOrder = id
            , ppSort = (fmap.fmap) reverse getSortByIndex
            , ppExtras = []
            , ppOutput = hPutStrLn xmobar
            }

        myConfig = def
            { borderWidth        = 1
            , terminal           = "urxvt"
            , modMask            = mod4Mask
            , startupHook        = myStartupHook
            , handleEventHook    = docksEventHook
            , focusFollowsMouse  = True
            , clickJustFocuses   = True
            , normalBorderColor  = black
            , focusedBorderColor = black
            , workspaces         = map fst tagKeys
            , layoutHook         = avoidStruts myLayoutHook
            , logHook            = fixFloatBorderColor base01 <+> dynamicLogWithPP pp
            , manageHook         = manageDocks
            , keys               = myKeys
            , mouseBindings      = myMouseBindings
            }

    xmonad myConfig


tagKeys :: [(WorkspaceId, KeySym)]
tagKeys = [ ("G", xK_g)
          , ("F", xK_f)
          , ("D", xK_d)
          , ("S", xK_s)
          , ("A", xK_a)
          ]


fixFloatBorderColor :: String -> X ()
fixFloatBorderColor color = do
    keys <- gets $ M.keys . W.floating . windowset
    withDisplay $ \d -> io $ do
        mpix <- initColor d color
        case mpix of
            Nothing -> error "Main.fixFloatBorderColor"
            Just pix -> let go w = setWindowBorder d w pix
                        in mapM_ go keys


myStartupHook = setWMName "LG3D"


myLayoutHook :: Choose Tall (Choose (Mirror Tall) Full) a
myLayoutHook = tiled ||| Mirror tiled ||| Full
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100


myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys (XConfig {..}) = M.fromList $

    -- # meta

    -- launching and killing programs
    [ ((modMask, xK_c), spawn terminal) -- Launch terminal
    , ((modMask, xK_u), spawn "vlaunch") -- Launch hacky launcher
    , ((modMask, xK_minus), spawn "vmctl") -- Launch hacky music chooser
    , ((modMask, xK_equal), spawn "popout 110 30") -- Launch floating urxvt
    , ((modMask, xK_x), kill) -- Close the focused window

    -- quit or restart
    , ((modMask, xK_y), io (exitWith ExitSuccess)) -- Quit xmonad
    , ((modMask, xK_r), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") -- Restart xmonad

    -- # inter-workspace

    -- movement between workspaces adjascent in the config tag list or in time
    , ((mod1Mask, xK_p  ), toggleWS) -- Move to last viewed workspace
    , ((mod1Mask, xK_Tab), toggleWS) -- Move to last viewed workspace
    , ((modMask, xK_n   ), nextWS  ) -- Move to next workspace in stack
    , ((modMask, xK_p   ), prevWS  ) -- Move to previous workspace in stack
    ] ++

    -- mod-N: Switch to workspace N
    -- mod-shift-N: Move client to workspace N
    [ ((m .|. modMask, k), windows $ f i)
    | (i, k) <- tagKeys
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ] ++

    -- mod-{1,2,3}: Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}: Move client to screen 1, 2, or 3
    [ ((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
    | (key, sc) <- zip [xK_1, xK_2, xK_3] [0..]
    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ] ++

    -- # intra-workspace

    -- changing layouts
    [ ((modMask              , xK_space ), sendMessage NextLayout) -- Rotate through the available layout algorithms
    , ((modMask .|. shiftMask, xK_space ), setLayout layoutHook) -- Reset the layouts on the current workspace to default

    -- move focus up or down the window stack
    , ((modMask, xK_j), windows W.focusDown  ) -- Move focus to the next window
    , ((modMask, xK_k), windows W.focusUp    ) -- Move focus to the previous window
    , ((modMask, xK_m), windows W.focusMaster) -- Move focus to the master window

    -- modifying the window order
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  ) -- Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    ) -- Swap the focused window with the previous window
    , ((modMask .|. shiftMask, xK_m     ), windows W.swapMaster) -- Swap the focused window and the master window

    -- increase or decrease number of windows in the master area
    , ((modMask, xK_period), sendMessage (IncMasterN   1 )) -- Increment the number of windows in the master area
    , ((modMask, xK_comma ), sendMessage (IncMasterN (-1))) -- Deincrement the number of windows in the master area

    -- resizing the master/slave ratio
    , ((modMask, xK_h), sendMessage Shrink) -- Shrink the master area
    , ((modMask, xK_l), sendMessage Expand) -- Expand the master area

    -- misc
    , ((modMask, xK_i), withFocused $ windows . W.sink) -- Push window back into tiling
    ]


myMouseBindings :: XConfig Layout -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings (XConfig {..}) = M.fromList
    -- Set the window to floating mode and move by dragging
    [ ((modMask, button1), \w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)
    -- Raise the window to the top of the stack
    , ((modMask, button2), windows . (W.shiftMaster .) . W.focusWindow)
    -- Set the window to floating mode and resize by dragging
    , ((modMask, button3), \w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)
    ]


-- SOLARIZED COLORS

black = "#000000"
white = "#ffffff"

base03  = "#002b36"
base02  = "#073642"
base01  = "#586e75"
base00  = "#657b83"
base0   = "#839496"
base1   = "#93a1a1"
base2   = "#eee8d5"
base3   = "#fdf6e3"

yellow  = "#b58900"
orange  = "#cb4b16"
red     = "#dc322f"
magenta = "#d33682"
violet  = "#6c71c4"
blue    = "#268bd2"
cyan    = "#2aa198"
green   = "#859900"
