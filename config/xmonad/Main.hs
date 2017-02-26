{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE OverloadedStrings #-}


module Main where


import           XMonad.Util.StatusBar
import           XMonad.Util.PopUp
import           XMonad.Util.Terminal

import           Minibar
import           Minibar.My
import           Data.LOT
import           Data.Colors
import           Control.Variable

import           XMonad
import qualified XMonad.StackSet as W

import           XMonad.Actions.CycleWS

import           Control.Concurrent
import           Control.Exception
import           Data.Monoid
import qualified Data.Map as M
import           Control.Monad
import           System.Exit
import           System.IO
import           System.Posix.Process (executeFile)
import           System.Posix.Env (getEnvironment)


myNormalBorderColor = black
myFocusedBorderColor = black
myFloatBorderColor = base01


floatBorderColor :: String -> X ()
floatBorderColor color = do
    keys <- gets $ M.keys . W.floating . windowset
    withDisplay $ \d -> io $ do
        mpix <- initColor d color
        case mpix of
            Nothing -> error "XMonad.Config.Uration.floatBorderColor"
            Just pix -> let go w = setWindowBorder d w pix
                        in mapM_ go keys


main :: IO ()
main = do

    hSetBuffering stdout NoBuffering
    hSetBuffering stderr NoBuffering

    forkIO $ spawnPty ["-title", "statusbar"] >>= flip minibar myMinibar

    let myLogHook = floatBorderColor myFloatBorderColor

        myManageHooks = statusBar <+> popUp <+> float
          where
            statusBar = title =? "statusbar" --> doStatusBar myNormalBorderColor U 0
            popUp     = title =? "popup"     --> doPopUp 40 40
            float     = title =? "float"     --> doFloat

        myConfig = def
            -- simple
            { borderWidth        = 1
            , terminal           = "xterm"
            , modMask            = mod4Mask
            , startupHook        = return ()
            , manageHook         = myManageHooks
            , handleEventHook    = const $ return (All True)
            , focusFollowsMouse  = True
            , clickJustFocuses   = True
            , normalBorderColor  = myNormalBorderColor
            , focusedBorderColor = myFocusedBorderColor

            -- more complex
            , workspaces         = map fst tagKeys
            , layoutHook         = vbox
            , logHook            = myLogHook
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


vbox :: Choose Tall (Choose (Mirror Tall) Full) a
vbox = tiled ||| Mirror tiled ||| Full
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

launch :: String
launch = "xlaunch -title popup"

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys (XConfig {..}) = M.fromList $ meta ++ interWorkspace ++ intraWorkspace

  where

    meta =

        -- launching and killing programs
        [ ((modMask, xK_c), spawn terminal) -- Launch terminal
        , ((modMask, xK_u), spawn launch) -- Launch hacky launcher
        , ((modMask, xK_x), kill) -- Close the focused window

        -- quit, or restart
        , ((modMask, xK_y), io (exitWith ExitSuccess)) -- Quit xmonad
        , ((modMask, xK_r), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") -- Restart xmonad
        ]

    interWorkspace =

        -- movement between workspaces adjascent in the config tag list or in time
        [ ((mod1Mask, xK_p  ), toggleWS) -- Move to last viewed workspace
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
        ]

    intraWorkspace =

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


minibar :: VVar (Int -> [Chunk])
minibar = (fmap (fromMaybe waiting)) . getCompose $ f
    <$> date <*> cpu <*> mem <*> bat <*> wifi
  where
    waiting width = raw "waiting"
    f date cpu mem bat wifi width = stradle width left right
      where
        right = date
        left = cpu <> raw " | " <> mem <> raw " | " <> wifi <> raw " | " <> bat
