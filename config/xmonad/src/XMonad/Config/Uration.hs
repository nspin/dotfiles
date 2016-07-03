{-# LANGUAGE RecordWildCards #-}

-- This file is based off of XMonad/Config.hs

module XMonad.Config.Uration
    ( main
    ) where

-- xmonad
import           XMonad
import qualified XMonad.StackSet as W

-- xmonad-contrib
import           XMonad.Actions.CycleWS
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.ManageHook
import           XMonad.Util.Run
import           XMonad.Util.WorkspaceCompare
import           XMonad.Layout.Spacing

-- base
import           Data.Monoid
import qualified Data.Map as M
import           System.IO
import           System.Exit

import           Control.Monad.Reader
import           Control.Concurrent

import           Control.Exception

import           Minibar
import           System.Posix.IO
import           System.Posix.Terminal
import           System.Process

main :: IO ()
main = do

    -- forkIO $ minibar (pure show)
    (master, slave) <- openPseudoTerminal
    slaveName <- getSlaveTerminalName master
    let cmd = "xterm -title statusline -geometry 80x1+0+0 -S" ++ slaveName ++ "/" ++ show master
    -- let cmd = "xterm -S" ++ slaveName ++ "/" ++ show master
    -- let cmd = "urxvt -pty-fd " ++ show master
    spawnCommand cmd
    h <- fdToHandle slave
    -- threadDelay 4000000
    hPutStr h "\27[8;1;0t"
    threadDelay 400000
    hPutStr h "hi"

    -- spawnCommand $ "xmessage '" ++ cmd ++ " # " ++ slaveName ++ "'"


    let myLogHook = do
            return ()

        -- myManageHook = ignore <+> avoid
        myManageHook = ignore
          where
            ignore = title =? "statusline" --> doIgnore
            -- avoid = Query . ReaderT $ \w -> do
            --     (_, x, y, width, height, _, _) <- getGeometry w
            --     return . Endo $ changeWith x y width height

        myConfig = def
            -- simple
            { borderWidth        = 1
            , terminal           = "xterm"
            , modMask            = mod4Mask
            , startupHook        = return ()
            , manageHook         = myManageHook
            , handleEventHook    = const $ return (All True)
            , focusFollowsMouse  = True
            , clickJustFocuses   = True
            , normalBorderColor  = border
            , focusedBorderColor = border

            -- more complex
            , workspaces         = map fst tagKeys
            , layoutHook         = avoidStruts $ vbox
            , logHook            = myLogHook
            , keys               = myKeys
            , mouseBindings      = myMouseBindings
            }

    xmonad myConfig

-- changeWith :: Position -> Position -> Dimension -> Dimension -> WindowSet -> WindowSet
-- changeWith x y width height (W.StackSet cur vis hid flo) = W.StackSet cur vis hid flo

border = "#073642"

-- workspace tags, along with keys to access them
tagKeys :: [(WorkspaceId, KeySym)]
tagKeys = [ ("G", xK_g)
          , ("F", xK_f)
          , ("D", xK_d)
          , ("S", xK_s)
          , ("A", xK_a)
          ]

-- layout for virtualbox on laptop
vbox :: Choose (Mirror Tall) (Choose Tall Full) a
vbox = Mirror tiled ||| tiled ||| Full
-- vbox :: Choose (Mirror Tall) (Choose Tall Full) a
-- vbox = Mirror tiled ||| tiled ||| Full
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

-- key bindings
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys (XConfig {..}) = M.fromList $ meta ++ interWorkspace ++ intraWorkspace

  where

    meta =
        -- launching and killing programs
        [ ((modMask, xK_c), spawn terminal) -- %! Launch terminal
        , ((modMask, xK_u), spawn dmenu) -- %! Launch dmenu
        , ((modMask, xK_x), kill) -- %! Close the focused window

        -- quit, or restart
        , ((modMask, xK_y), io (exitWith ExitSuccess)) -- %! Quit xmonad
        , ((modMask, xK_r), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") -- %! Restart xmonad
        ]

    interWorkspace =
        -- movement between workspaces adjascent in the config tag list or in time
        [ ((mod1Mask, xK_p), toggleWS) -- %! Quick move to last viewed workspace
        , ((modMask, xK_q), toggleWS) -- %! Move to last viewed workspace
        , ((modMask, xK_n), nextWS  ) -- %! Move to next workspace in stack
        , ((modMask, xK_p), prevWS  ) -- %! Move to previous workspace in stack
        ] ++

        -- mod-N %! Switch to workspace N
        -- mod-shift-N %! Move client to workspace N
        [ ((m .|. modMask, k), windows $ f i)
        | (i, k) <- tagKeys
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
        ] ++

        -- mod-{1,2,3} %! Switch to physical/Xinerama screens 1, 2, or 3
        -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
        [ ((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_1, xK_2, xK_3] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
        ]

    intraWorkspace =
        -- changing layouts
        [ ((modMask              , xK_space ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
        , ((modMask .|. shiftMask, xK_space ), setLayout layoutHook) -- %!  Reset the layouts on the current workspace to default

        -- move focus up or down the window stack
        , ((modMask, xK_j), windows W.focusDown  ) -- %! Move focus to the next window
        , ((modMask, xK_k), windows W.focusUp    ) -- %! Move focus to the previous window
        , ((modMask, xK_m), windows W.focusMaster) -- %! Move focus to the master window

        -- modifying the window order
        , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
        , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window
        , ((modMask .|. shiftMask, xK_m     ), windows W.swapMaster) -- %! Swap the focused window and the master window

        -- increase or decrease number of windows in the master area
        , ((modMask, xK_period), sendMessage (IncMasterN   1 )) -- %! Increment the number of windows in the master area
        , ((modMask, xK_comma ), sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area

        -- resizing the master/slave ratio
        , ((modMask, xK_h), sendMessage Shrink) -- %! Shrink the master area
        , ((modMask, xK_l), sendMessage Expand) -- %! Expand the master area

        -- misc
        , ((modMask, xK_i), withFocused $ windows . W.sink) -- %! Push window back into tiling
        ]

-- dmenu command -- TODO make this work
dmenu :: String
dmenu = "dmenu_run -fn \"-*-*-*-*-*-*-18-*-*-*-*-*-*-*\""
    -- dmenu = "dmenu_run -fn \"-*-dejavu sans mono-*-*-*-*-*-*-*-*-*-*-*-*\""
    -- dmenu = "dmenu_run -fn \"-*-fixed-medium-*-*-*-18-*-*-*-*-*-*-*\""
    -- dmenu = "dmenu_run -fn \"-*-*-medium-r-*-*-18-*-*-*-*-*-*-*\""
    -- dmenu = "dmenu_run"

-- mouse bindings
myMouseBindings :: XConfig Layout -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings (XConfig {..}) = M.fromList
    -- mod-button1 %! Set the window to floating mode and move by dragging
    [ ((modMask, button1), \w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)
    -- mod-button2 %! Raise the window to the top of the stack
    , ((modMask, button2), windows . (W.shiftMaster .) . W.focusWindow)
    -- mod-button3 %! Set the window to floating mode and resize by dragging
    , ((modMask, button3), \w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)
    ]
