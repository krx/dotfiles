import Control.Monad
import System.IO
import System.Process
import Text.Printf
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import qualified XMonad.Hooks.EwmhDesktops as EMWH
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.Circle
import XMonad.Layout.Fullscreen
import XMonad.Layout.Grid
import qualified XMonad.Layout.LayoutCombinators as LC
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.WindowNavigation
import qualified XMonad.Layout.WindowNavigation as WN
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.Scratchpad

term = "termite"

-- Keybindings {{{
modm = mod1Mask
myKeys =
    -- Launcher/switcher
    [ ((modm .|. shiftMask, xK_r), spawn "killall dzen2; killall stalonetray; xmonad --recompile; xmonad --restart")

    , ((modm .|. shiftMask, xK_q),   kill)
    , ((modm,               xK_q),   return ())
    , ((modm,               xK_p),   spawn "startrofi run")
    , ((modm .|. shiftMask, xK_Tab), windows W.focusUp)

    -- Shortcuts like other wms
    , ((modm,               xK_Return), spawn term)
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)

    -- Navigation
    , ((modm,               xK_h), sendMessage $ Go   L)
    , ((modm,               xK_j), sendMessage $ Go   D)
    , ((modm,               xK_k), sendMessage $ Go   U)
    , ((modm,               xK_l), sendMessage $ Go   R)
    , ((modm .|. shiftMask, xK_h), sendMessage $ Swap L)
    , ((modm .|. shiftMask, xK_j), sendMessage $ Swap D)
    , ((modm .|. shiftMask, xK_k), sendMessage $ Swap U)
    , ((modm .|. shiftMask, xK_l), sendMessage $ Swap R)

    {-, ((modm, xK_grave), scratchpadSpawnActionTerminal term)-}
    ]

myMouse =
    [((0, button1 .|. button3), (\w -> focus w >> mouseMoveWindow w))]
 -- }}}

-- Workspaces {{{
-- Allow these to be clickable in dzen2
myWorkspace :: [String]
myWorkspace = clickable $ (map show [1 .. 10])
  where
    clickable l =
        [ "^ca(1,xdotool key alt+" ++ show (n) ++ ")" ++ ws -- ++ "^ca()" moving this to the PP
        | (i, ws) <- zip [1 ..] l
        , let n = i
        ]
-- }}}

-- Layout settings {{{
gapSize = 10
myLayout =  windowNavigation $
            avoidStruts (gapTall ||| gapGrid ||| noBorders Full)
  where
    gapGrid = spacing gapSize $ Grid
    gapTall = spacing gapSize $ Tall 1 (1 / 2) (1 / 2)
-- }}}

{-scHook :: ManageHook-}
{-scHook = scratchpadManageHook (W.RationalRect l t w h)-}
  {-where-}
    {-h = 0.1-}
    {-w = 1-}
    {-t = 0.1-}
    {-l = 1 - w-}

-- Hooks {{{
myManageHook = composeAll
    [ className =? "Viewnior" --> doCenterFloat
    , className =? "feh"      --> doCenterFloat
    , className =? "Oblogout" --> doFullFloat
    , className =? "stalonetray" --> doFloat
    , className =? "Thunar" --> doFloat
    , isFullscreen --> doFullFloat
    {-, scHook-}
    , manageDocks
    , manageHook def
    ]

myStartupHook = composeAll
    [ ewmhDesktopsStartup
    , docksStartupHook
    , setWMName "LG3D"
    {-, spawn "sleep 2; i3lock-krx"-}
    , spawnOnce "/home/krx/.xmonad/bin/autorun-xmonad"
    ]
-- }}}

-- Gruvbox color  scheme {{{
-- probably (definitely) don't need all of these here
col_dark0_hard     = "#1d2021"
col_dark0          = "#282828"
col_dark0_soft     = "#32302f"
col_dark1          = "#3c3836"
col_dark2          = "#504945"
col_dark3          = "#665c54"
col_dark4          = "#7c6f64"
col_dark4_256      = "#7c6f64"

col_gray_245       = "#928374"
col_gray_244       = "#928374"

col_light0_hard    = "#f9f5d7"
col_light0         = "#fbf1c7"
col_light0_soft    = "#f2e5bc"
col_light1         = "#ebdbb2"
col_light2         = "#d5c4a1"
col_light3         = "#bdae93"
col_light4         = "#a89984"
col_light4_256     = "#a89984"

col_bright_red     = "#fb4934"
col_bright_green   = "#b8bb26"
col_bright_yellow  = "#fabd2f"
col_bright_blue    = "#83a598"
col_bright_purple  = "#d3869b"
col_bright_aqua    = "#8ec07c"
col_bright_orange  = "#fe8019"

col_neutral_red    = "#cc241d"
col_neutral_green  = "#98971a"
col_neutral_yellow = "#d79921"
col_neutral_blue   = "#458588"
col_neutral_purple = "#b16286"
col_neutral_aqua   = "#689d6a"
col_neutral_orange = "#d65d0e"

col_faded_red      = "#9d0006"
col_faded_green    = "#79740e"
col_faded_yellow   = "#b57614"
col_faded_blue     = "#076678"
col_faded_purple   = "#8f3f71"
col_faded_aqua     = "#427b58"
col_faded_orange   = "#af3a03"
-- }}}

-- dzen stuff {{{
icons = "/home/krx/.xmonad/icons/"
space = " "
scW = 1920
scH = 1080


-- Some helpers for formatting
dzesc f s = printf "^%s(%s)" f s
dzicon s = printf "^i(%s%s.xbm)" icons s
dzclick button action txt = "^ca(" ++ (show button) ++ "," ++ action ++ ")" ++ txt ++ "^ca()"
dzbg s = dzesc "bg" s
dzfg s = dzesc "fg" s
dzCycleLayout ico txt = dzclick 1 "xdotool key alt+space" ((dzicon ico) ++ txt)

-- Main colors I'm using here
col_corner = col_light4
col_info   = col_dark0_soft
col_blank  = col_dark0_hard


dzenBase = printf "dzen2 -dock -p -ta l -e 'button3=' -fn 'Input Mono Narrow-10' -h 20 -bg '%s' -fg '%s'"  col_blank col_info
dzWorkspaceBar = dzenBase ++ " -w 1000"
layTypeStart = (dzbg col_corner) ++ space
layTypeEnd = (dzfg col_corner) ++ (dzbg col_info) ++ (dzicon "mt1") ++ (dzfg "")

-- Pretty printe r for workspace info {{{
workspacePP :: Handle -> PP
workspacePP h = def
    { ppOutput = hPutStrLn h

    -- Workspace number coloring
    , ppCurrent  = dzenColor col_light1        col_info . pad . wrap space (space ++ "^ca()")
    , ppVisible  = dzenColor col_faded_aqua    col_info . pad . wrap space (space ++ "^ca()")
    , ppHidden   = dzenColor col_dark2         col_info . pad . wrap space (space ++ "^ca()")
    , ppUrgent   = dzenColor col_neutral_red   col_info . pad . wrap space (space ++ "^ca()")
    {-, ppHiddenNoWindows = dzenColor col_dark0_sof  col_light4 . pad . wrap space space-}

    -- Separation between sections
    , ppSep     = ""
    , ppWsSep   = ""
    , ppTitle   = \t ->  (dzbg col_blank) ++ (dzfg col_info) ++ dzicon "mt1"

    -- Show the current layout w/ icon
    , ppLayout  = wrap layTypeStart layTypeEnd .
        ( \t -> case t of
        "Spacing 10 Grid" -> dzCycleLayout "grid" (space ++ "Grid")
        "Spacing 10 Tall" -> dzCycleLayout "tall" (space ++ "Tall")
        "Full"            -> dzCycleLayout "full" (space ++ "Full")
        )
    , ppOrder = \(ws:l:t:_) -> [l, ws, t]
    }

logHookWorkspace h = do
    dynamicLogWithPP $ workspacePP h
-- }}}

-- Simple PP for the current window title {{{
dzTitleBar = dzenBase ++ " -x 100 -w 900 -y " ++ show (scH - 20)
traySpace = concat $ replicate 21 space
titleStart =       (dzbg col_dark2) ++ (dzfg col_corner) ++ (dzicon "mr1")
                ++ traySpace
                ++  (dzbg col_info) ++ (dzfg col_dark2) ++ (dzicon "mr1")
                ++ (dzfg col_corner) ++ space
titleEnd   = space ++ (dzbg col_blank) ++ (dzfg col_info) ++ (dzicon "mr1")

titlePP :: Handle -> PP
titlePP h = def
    { ppOutput = hPutStrLn h
    , ppSep    = ""

    -- Get the title to display
    , ppTitle = wrap titleStart titleEnd . shorten 50 .
        ( \t ->
            if t == []
            then "ghost"
            else t
        )

    -- Only show title here
    , ppOrder = \(ws:l:t:_) -> [t]
    }

logHookTitle h = do
    dynamicLogWithPP $ titlePP h

-- }}}

dzStatusBar = "dz_comp_info.py"
dzAudioBar = "dz_audio.py"
dzMenuBar = "dz_menu.py"

-- }}}

-- main config {{{
main = do
    wsbar <- spawnPipe dzWorkspaceBar
    titlebar <- spawnPipe dzTitleBar
    statusbar <- spawnPipe dzStatusBar
    audiobar <- spawnPipe dzAudioBar
    menubar <- spawnPipe dzMenuBar
    xmonad $
        ewmh -- Provides additional windows imfo to other programs
            def
            { modMask = modm
            , terminal = term
            , workspaces = myWorkspace

            , startupHook = myStartupHook
            , layoutHook = myLayout
            , manageHook = myManageHook
            , handleEventHook = handleEventHook def
                                <+> docksEventHook
                                <+> EMWH.fullscreenEventHook

            -- Border settings
            , normalBorderColor = col_dark2
            , focusedBorderColor = col_light4
            , borderWidth = 3

            -- Status bar
            , logHook = logHookWorkspace wsbar <+> logHookTitle titlebar
            } `additionalKeys` myKeys -- `additionalMouseBindings` myMouse

-- }}}

