{-# LANGUAGE  MultiParamTypeClasses, TypeSynonymInstances, FlexibleContexts #-}
--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Actions.CycleWS
--import XMonad.Actions.KeyRemap
import Data.List
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageHelpers
import XMonad.Util.Run
--import XMonad.Layout.IM
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Grid
import Data.Ratio ((%))
import XMonad.Layout.LayoutModifier
import XMonad.Util.WindowProperties
import Control.Monad


-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "urxvtc -e tmux"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

alt = mod1Mask
shift = shiftMask
meta = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
--myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]
myWorkspaces    = ["IM", "Mail", "IRC", "Web", "a", "o", "e", "u", "i", "d", "h", "t", "n", "s"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

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
    -- , ((meta,        xK_b           ), sendMessage ToggleStruts)

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
    , ((meta,           xK_F1          ), spawn "setxkbmap us dvorak -option ctrl:nocaps && xmodmap ~/.xmonad/dvorak_remap_xmodmap; killall xcape; xcape -e 'Control_L=Escape'")
    , ((meta,           xK_F2          ), spawn "setxkbmap fr bepo -option ctrl:nocaps; killall xcape; xcape -e 'Control_L=Escape'")
    , ((meta,           xK_F3          ), spawn "setxkbmap fr -option ctrl:nocaps; killall xcape; xcape -e 'Control_L=Escape'")
    , ((meta,           xK_F4          ), spawn "setxkbmap us -option ctrl:nocaps; killall xcape; xcape -e 'Control_L=Escape'")

    -- Lock
    , ((meta,           xK_BackSpace   ), spawn "alock -auth pam")

    -- Volume control
    , ((0,              0x1008ff13     ), spawn "amixer -q sset Master 5%+")
    , ((0,              0x1008ff11     ), spawn "amixer -q sset Master 5%-")
    , ((0,              0x1008ff13     ), spawn "amixer -q sset Master 5%+")
    , ((0,              0x1008ff12     ), spawn "amixer -q sset Master toggle")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. alt, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_semicolon, xK_comma, xK_period, xK_p, xK_a, xK_o, xK_e, xK_u, xK_i, xK_d, xK_h, xK_t, xK_n, xK_s]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shift)]]
    -- ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    --[((m .|. meta, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --    | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    --    , (f, m) <- [(W.view, 0), (W.shift, shift)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
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
myLayout = onWorkspaces ["IM"] imLayout $ customLayouts
  where
     imLayout = avoidStruts $ withIMs (1%7) [pidginRoster, skypeRoster] Grid
     pidginRoster = And (ClassName "Pidgin") (Role "buddy_list")
     skypeRoster = And (ClassName "Skype") (Not (Role "ConversationsWindow"))

     customLayouts = avoidStruts $ tiled ||| Mirror tiled ||| Full ||| Grid

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
    , [className =? c    --> doShift "IM"     | c <- myIM      ]
    , [className =? c    --> doShift "Mail"   | c <- myMail    ]
    , [className =? c    --> doShift "IRC"    | c <- myIRC     ]
    , [className =? c    --> doShift "Web"    | c <- myWeb     ]
    , [className =? c    --> doCenterFloat    | c <- myFloats  ]
    , [isFullscreen      --> myDoFullFloat                       ]
    ]) where
        myIgnores = ["desktop", "desktop_window", "kdesktop"]
        myIM = ["Pidgin", "Skype"]
        myMail = ["Thunderbird"]
        myIRC = []
        myWeb = ["Firefox", "Chromium"]
        myFloats = ["Xmessage", "Downloads", "Download"]

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
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook h = dynamicLogWithPP $ defaultPP
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
    }

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
    setWMName "LG3D"
--    setDefaultKeyRemap emptyKeyRemap [dvorakAzertyRemap, emptyKeyRemap]

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
    let dzenSplit = 1000
    let dzenWidth = 1920 + 1680
    dzenXMonadBar <- spawnPipe $ "dzen2 -x '0' -y '0' -h '24' -w '" ++ show dzenSplit ++ "' -ta 'l' -fg '#FFFFFF' -bg '#1B1D1E'"
    dzenConkyBar <- spawnPipe $ "conky -c /home/twal/.xmonad/.conky_dzen | dzen2 -x '" ++ show dzenSplit ++ "' -w '" ++ show (dzenWidth - dzenSplit) ++ "' -h '24' -ta 'r' -bg '#1B1D1E' -fg '#FFFFFF' -y '0'"
    --conkyMisc <- spawnPipe "/home/twal/.xmonad/start.sh nice -n 19 conky -c ~/confs/conky/misc/.conkyrc"
    --conkyMisc <- spawnPipe "/home/twal/.xmonad/start.sh nice -n 19 conky -c ~/confs/conky/graphs/.conkyrc"
    --conkyRing <- spawnPipe "/home/twal/.xmonad/start.sh nice -n 19 conky -c ~/confs/conky/rings/.conkyrc"
    spawnPipe "setxkbmap us dvorak -option ctrl:nocaps && xmodmap ~/.xmonad/dvorak_remap_xmodmap; killall xcape; xcape -e 'Control_L=Escape'"
    spawnPipe "/home/twal/.xmonad/start.sh redshift -l 43.63:1.37"
    spawnPipe "/home/twal/.xmonad/start.sh urxvtd"
    spawnPipe "xrandr --output DP-0 --left-of DP-1"
    --spawnPipe "killall xcape"
    --spawnPipe "/bin/sh -c xcape -e 'Control_L=Escape'"
    xmonad defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook dzenXMonadBar >> fadeInactiveLogHook 0xdddddddd,
        startupHook        = myStartupHook
    }

-- modified version of XMonad.Layout.IM --

-- | Data type for LayoutModifier which converts given layout to IM-layout
-- (with dedicated space for the roster and original layout for chat windows)
data AddRosters a = AddRosters Rational [Property] deriving (Read, Show)

instance LayoutModifier AddRosters Window where
  modifyLayout (AddRosters ratio props) = applyIMs ratio props
  modifierDescription _                = "IMs"

-- | Modifier which converts given layout to IMs-layout (with dedicated
-- space for rosters and original layout for chat windows)
withIMs :: LayoutClass l a => Rational -> [Property] -> l a -> ModifiedLayout AddRosters l a
withIMs ratio props = ModifiedLayout $ AddRosters ratio props

-- | IM layout modifier applied to the Grid layout
gridIMs :: Rational -> [Property] -> ModifiedLayout AddRosters Grid a
gridIMs ratio props = withIMs ratio props Grid

hasAnyProperty :: [Property] -> Window -> X Bool
hasAnyProperty [] _ = return False
hasAnyProperty (p:ps) w = do
    b <- hasProperty p w
    if b then return True else hasAnyProperty ps w

-- | Internal function for placing the rosters specified by
-- the properties and running original layout for all chat windows
applyIMs :: (LayoutClass l Window) =>
               Rational
            -> [Property]
            -> W.Workspace WorkspaceId (l Window) Window
            -> Rectangle
            -> X ([(Window, Rectangle)], Maybe (l Window))
applyIMs ratio props wksp rect = do
    let stack = W.stack wksp
    let ws = W.integrate' $ stack
    rosters <- filterM (hasAnyProperty props) ws
    let n = {-fromIntegral $-} length rosters
    let (rostersRect, chatsRect) = splitHorizontallyBy ((fromIntegral n) * ratio) rect
    let rosterRects = splitHorizontally n rostersRect
    let filteredStack = stack >>= W.filter (`notElem` rosters)
    (a,b) <- runLayout (wksp {W.stack = filteredStack}) chatsRect
    return (zip rosters rosterRects ++ a, b)
