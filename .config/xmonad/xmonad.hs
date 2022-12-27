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
import XMonad.Actions.WindowGo
import XMonad.Actions.Minimize
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Magnifier as Mag
import XMonad.Layout.Minimize
import XMonad.Layout.MultiColumns
-- import XMonad.Layout.ResizableThreeColumns
import qualified XMonad.Layout.BoringWindows as BW
import XMonad.Prompt
import XMonad.Prompt.Workspace
import XMonad.Util.NamedScratchpad
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
-- myTerminal      = "alacritty"
-- myTerminalClass = "Alacritty"
myTerminal = "gnome-terminal"
myTerminalClass = "Gnome-terminal"
mySubTerminal      = "gnome-terminal"
mySubTerminalClass = "Gnome-terminal"

myBrowser = "google-chrome"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 5

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["home", "files","zoom", "firefox", "obs", "openshot"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ 
      -- ((modm, xK_t), runOrRaise myTerminal (className =? myTerminalClass))

      ((modm, xK_space), namedScratchpadAction myScratchPads "terminal")
    -- , ((modm .|. shiftMask, xK_space), namedScratchpadAction myScratchPads "subterminal")
    , ((modm .|. shiftMask, xK_space), spawn "~/settings-ubuntu/executables/toggle_alacritty_opacity")

    , ((modm, xK_b), allNamedScratchpadAction myScratchPads "browser")
    -- , ((modm, xK_e), allNamedScratchpadAction myScratchPads "filemanager")
    , ((modm, xK_e), spawn "nautilus")
     

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm ,               xK_w ), sendMessage NextLayout)

    -- --  Reset the layouts on the current workspace to default
    -- , ((modm .|. shiftMask, xK_r ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_Return     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm .|. shiftMask,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    , ((modm,               xK_h     ), moveTo Prev $  ignoringWSs [scratchpadWorkspaceTag])

    , ((modm,               xK_l     ), moveTo Next $  ignoringWSs [scratchpadWorkspaceTag])
    , ((modm .|. shiftMask,               xK_h     ), (shiftTo Prev ( ignoringWSs [scratchpadWorkspaceTag])) >> (moveTo Prev ( ignoringWSs [scratchpadWorkspaceTag])))
    , ((modm .|. shiftMask,               xK_l     ), (shiftTo Next ( ignoringWSs [scratchpadWorkspaceTag])) >> (moveTo Next ( ignoringWSs [scratchpadWorkspaceTag])))
    , ((modm, xK_g), ( workspacePrompt def (windows . W.greedyView)))

    -- -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), namedScratchpadAction myScratchPads "autokey")


    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    -- , ((modm              , xK_q     ), spawn "~/settings-ubuntu/executables/reconfig_xmonad")
    , ((modm              , xK_q     ), unsafeSpawn "xmonad --recompile; xmonad --restart" ) 

    , (( modm .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
    , (( 0, 0x1008FF12), spawn "amixer -D pulse sset Master 0%")
    , (( 0, 0x1008FF11), spawn "amixer -D pulse sset Master 2%-")
    , (( 0, 0x1008FF13), spawn "amixer -D pulse sset Master 2%+")
    

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    -- ++

    -- --
    -- -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    -- --
    -- [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --     | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    --     , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


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
myLayout =  avoidStruts (multiCol [1] 1 0.01 (-0.5) ||| Full)

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
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Org.gnome.Nautilus" --> doShift "files"
    , className =? "zoom" --> doShift "zoom"
    , className =? "obs" --> doShift "obs"
    , className =? "openshot" --> doShift "openshot"
    , className =? "firefox" --> doShift "firefox"
    -- , className =? "libreoffice-writer" --> doShift "office"
    -- , className =? myTerminalClass  --> doFullFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]
    <+> namedScratchpadManageHook myScratchPads

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
-- myLogHook = return () -- dynamicLogWithPP $ def { ppOutput = hPutStrLn xmproc }


------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
  spawnOnce "nitrogen --restore &"
  spawnOnce "picom &"
  -- spawnOnce "code ~/settings-ubuntu/ &"
  spawnOnce "autokey &"
  spawnOnce "xmodmap ~/.Xmodmap"
  spawnOnce "xscreensaver &"
  spawnOnce "dropbox start"



--------------------------------------------------------
--
-- Named Scratchpad
myScratchPads = [
  NS "terminal" spawnTerm findTerm manageTerm
  , NS "subterminal" "xterm" (className =? "XTerm") nonFloating
  , NS "settings" "code ~/settings-ubuntu" (className =? "Code") nonFloating
  , NS "autokey" "autokey -c" (className =? "autokey") nonFloating
  , NS "browser" "google-chrome" (className =? "Google-chrome") nonFloating
  , NS "filemanager" "nautilus" (className =? "Org.gnome.Nautilus") nonFloating
  ] 
  where
    spawnTerm = myTerminal
    findTerm = className =? myTerminalClass
    manageTerm = doRectFloat $ W.RationalRect x y w h
      where
        x = 0
        y = 0.02
        w = 1
        h = 0.98
    -- manageTerm = nonFloating



------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
  xmproc <- spawnPipe "xmobar -x 0 ~/.config/xmobar/xmobar.hs"
  xmonad . docks $ ewmh def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
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
        logHook            = dynamicLogWithPP $ xmobarPP {
            ppOutput = hPutStrLn xmproc,
            ppOrder  = \(ws:l:_) -> [ws,l]
        },
        startupHook        = myStartupHook
    }

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
