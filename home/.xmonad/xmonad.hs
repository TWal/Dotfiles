{-# LANGUAGE  MultiParamTypeClasses, TypeSynonymInstances, FlexibleContexts #-}

import XMonad
import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Actions.CycleWS
import Data.List
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Util.Run
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Grid
import Data.Ratio ((%))
import XMonad.Layout.LayoutModifier
import XMonad.Util.WindowProperties
import Graphics.X11.ExtraTypes.XF86
import Control.Monad
import XMonad.Layout.NoBorders
import XMonad.Actions.UpdatePointer

--Accordion, Acordion, Circle?, OneBig, Roledex?
--Combinator : (MagicFocus?), Magnifier?, Master+ToggleLayout
--NoBorder

--Actions : Submap

alt = mod1Mask
shift = shiftMask
meta = mod4Mask
setxkbmapCommand = "setxkbmap -option compose:rctrl -option ctrl:nocaps "

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
-- Comments above each bind: what_does_the_bind (the_key_in_azerty)
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal              |
    [ ((meta,           xK_Return      ), spawn $ XMonad.terminal conf)

    -- launch dmenu (a)
    , ((meta,           xK_semicolon   ), spawn "dmenu_run")

    -- launch gmrun
    --, ((meta .|. shift, xK_p           ), spawn "gmrun")

    -- close focused window (c)
    , ((meta .|. shift, xK_j           ), kill)

     -- Rotate through the available layout algorithms
    , ((meta,           xK_space       ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((meta .|. shift, xK_space       ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size (n)
    , ((meta,           xK_b           ), refresh)

    -- Move focus to the next window
    , ((alt,            xK_Tab         ), windows W.focusDown)

    -- Move focus to the next window (j)
    , ((meta,           xK_h           ), windows W.focusDown)

    -- Move focus to the previous window (k)
    , ((meta,           xK_t           ), windows W.focusUp  )

    -- Move focus to the previous window
    , ((alt .|. shift,  xK_Tab         ), windows W.focusUp  )

    -- Move focus to the master window
    , ((meta,           xK_m           ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((meta .|. shift, xK_Return      ), windows W.swapMaster)

    -- Swap the focused window with the next window (j)
    , ((meta .|. shift, xK_h           ), windows W.swapDown  )

    -- Swap the focused window with the previous window (k)
    , ((meta .|. shift, xK_t           ), windows W.swapUp    )

    -- Shrink the master area (h)
    , ((meta,           xK_d           ), sendMessage Shrink)

    -- Expand the master area (l)
    , ((meta,           xK_n           ), sendMessage Expand)

    -- Push window back into tiling (t)
    , ((meta,           xK_y           ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    --, ((meta,           xK_comma       ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    --, ((meta,           xK_period      ), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    , ((meta,        xK_x           ), sendMessage ToggleStruts)

    -- Quit xmonad (x)
    , ((meta .|. shift, xK_q           ), io (exitWith ExitSuccess))

    -- Restart xmonad (x)
    , ((meta,           xK_q           ), spawn "killall dzen2; xmonad --recompile && xmonad --restart")

    -- CycleWS setup
    , ((meta,           xK_Right       ), nextWS)
    , ((meta,           xK_Left        ), prevWS)
    , ((meta .|. shift, xK_Right       ), shiftToNext)
    , ((meta .|. shift, xK_Left        ), shiftToPrev)

    -- KeyRemap setup
    , ((meta,           xK_F1          ), spawn $ setxkbmapCommand ++ "us dvorak && xmodmap ~/.xmonad/dvorak_remap_xmodmap; killall xcape; xcape -e 'Control_L=Escape'")
    , ((meta,           xK_F2          ), spawn $ setxkbmapCommand ++ "fr bepo; killall xcape; xcape -e 'Control_L=Escape'")
    , ((meta,           xK_F3          ), spawn $ setxkbmapCommand ++ "fr; killall xcape; xcape -e 'Control_L=Escape'")
    , ((meta,           xK_F4          ), spawn $ setxkbmapCommand ++ "us; killall xcape; xcape -e 'Control_L=Escape'")
    , ((meta,           xK_F5          ), spawn $ "setxkbmap us -option; killall xcape")

    -- Lock
    , ((meta,           xK_BackSpace   ), spawn "xset +dpms && xset dpms 10 10 10 && bash ~/.xmonad/lock.sh && xset dpms 900 900 900")

    -- Volume control
    , ((0, xF86XK_AudioRaiseVolume     ), spawn "amixer -q sset Master 5%+")
    , ((0, xF86XK_AudioLowerVolume     ), spawn "amixer -q sset Master 5%-")
    , ((0, xF86XK_AudioMute            ), spawn "amixer -q sset Master toggle")
    , ((0, xF86XK_MonBrightnessUp      ), spawn "xbacklight -inc 5")
    , ((0, xF86XK_MonBrightnessDown    ), spawn "xbacklight -dec 5")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. alt, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_apostrophe, xK_comma, xK_period, xK_p, xK_a, xK_o, xK_e, xK_u, xK_i, xK_d, xK_h, xK_t, xK_n, xK_s]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shift)]]
     ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. alt, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_g, xK_c, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shift)]]


------------------------------------------------------------------------

--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts . smartBorders $ tiled ||| Mirror tiled ||| Full ||| Grid
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio
     -- The default number of windows in the master pane
     nmaster = 1
     -- Default proportion of screen occupied by master pane
     ratio   = 1/2
     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = (composeAll . concat $
    [ [resource =? r     --> doIgnore         | r <- myIgnores ]
    , [className =? c    --> doShift "Pass"   | c <- myPass    ]
    , [className =? c    --> doShift "Mail"   | c <- myMail    ]
    , [className =? c    --> doShift "Web"    | c <- myWeb     ]
    , [className =? c    --> doCenterFloat    | c <- myFloats  ]
    , [isFullscreen      --> myDoFullFloat                     ]
    , [manageDocks]
    ]) where
        myIgnores = ["desktop", "desktop_window", "kdesktop"]
        myPass = ["KeePassXC"]
        myMail = ["Thunderbird"]
        myWeb = ["Firefox", "Chromium"]
        myFloats = ["Gxmessage", "Xmessage", "Downloads", "Download"]

-- a trick for fullscreen but stil allow focusing of other WSs
myDoFullFloat :: ManageHook
myDoFullFloat = doF W.focusDown <+> doFullFloat

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = docksEventHook

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook h = (dynamicLogWithPP $ defaultPP
    {
          ppCurrent           =   dzenColor "#ebac54" "#1B1D1E" . pad
        , ppVisible           =   dzenColor "white" "#1B1D1E" . pad
        , ppHidden            =   dzenColor "white" "#1B1D1E" . pad
        , ppHiddenNoWindows   =   dzenColor "#7b7b7b" "#1B1D1E" . pad
        , ppUrgent            =   dzenColor "#ff0000" "#1B1D1E" . pad
        , ppWsSep             =   ""
        , ppSep               =   "  |  "
        , ppTitle             =   (" " ++) . dzenColor "white" "#1B1D1E" . dzenEscape
        , ppOutput            =   hPutStrLn h
    })
    -- >> updatePointer (0.5, 0.5) (0, 0)



------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
    setWMName "LG3D"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
    let conkyBarWidth = 640 -- found this value experimentally
    let screenWidth = 1920 -- one 1080p screen
    let dzenConfig = "-h '22' -fn 'xft:DejaVu Sans Mono-8' -bg '#1B1D1E' -fg '#FFFFFF' -y '0'"
    dzenXMonadBar <- spawnPipe $ "dzen2 -dock -x '0' -w '" ++ show (screenWidth-conkyBarWidth)++ "' -ta 'l' " ++ dzenConfig
    dzenConkyBar <- spawnPipe $ "conky -c /home/twal/.xmonad/conky_dzen | dzen2 -dock -x '" ++ show (screenWidth-conkyBarWidth) ++ "' -w '" ++ show conkyBarWidth ++ "' -ta 'r' " ++ dzenConfig
    spawnPipe $ setxkbmapCommand ++ "us dvorak && xmodmap ~/.xmonad/dvorak_remap_xmodmap; killall xcape; xcape -e 'Control_L=Escape'"

    xmonad $ defaultConfig {
      -- simple stuff
        terminal           = "alacritty -e tmux",
        focusFollowsMouse  = True,
        borderWidth        = 1,
        modMask            = meta,
        workspaces         = ["Pass", "Mail", "Term", "Web", "a", "o", "e", "u", "i", "d", "h", "t", "n", "s"],
        normalBorderColor  = "#dddddd",
        focusedBorderColor = "#ff0000",

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook dzenXMonadBar,
        startupHook        = myStartupHook
    }

