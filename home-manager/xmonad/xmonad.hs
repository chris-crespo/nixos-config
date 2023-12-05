import XMonad
import XMonad.Actions.Submap (submap)
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks (docks, manageDocks)
import XMonad.Actions.Minimize
import XMonad.Layout.Minimize
import XMonad.Layout.NoBorders
import qualified XMonad.Layout.BoringWindows as BW
import XMonad.Layout.Fullscreen (fullscreenSupport)
import XMonad.Layout.Gaps (GapSpec, GapMessage (..), Direction2D (..), gaps, setGaps, weakModifyGaps)
import XMonad.Layout.LayoutModifier (ModifiedLayout)
import XMonad.Layout.Spacing (Border (Border), Spacing, spacing, spacingRaw)
import XMonad.Util.SpawnOnce (spawnOnce)

import Graphics.X11.ExtraTypes.XF86 
  ( xF86XK_MonBrightnessUp
  , xF86XK_MonBrightnessDown
  , xF86XK_AudioRaiseVolume
  , xF86XK_AudioLowerVolume
  , xF86XK_AudioMute
  , xF86XK_AudioMicMute
  )

import qualified XMonad.StackSet as W
import qualified Data.Map as M

myWorkspaces = [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" ]

myTerminal :: String
myTerminal = "kitty -o allow_remote_control=yes"

terminalExec :: String
terminalExec = myTerminal

editor :: String
editor = "nvim"

configDir :: String
configDir = "~/config"

myBorderWidth = 2

myFocusedBorderColor :: String
myFocusedBorderColor = "#f2cdcd"

myNormalBorderColor :: String
myNormalBorderColor = "#313244"

myManageHook = manageDocks <+> insertPosition Below Newer <+> composeAll []

myStartupHook :: X ()
myStartupHook = do
  spawn     "xset r rate 200 40"
  spawn     "xsetroot -cursor_name left_ptr"
  spawnOnce "feh --bg-scale ~/wallpapers/street.jpg"
  spawnOnce "eww daemon & eww open-many time-side sys-side"
  spawnOnce "dunst"
  spawnOnce "dunstctl set-paused true"
  spawnOnce "picom --experimental-backends"

noGaps = [ (L, 0), (R, 0), (U, 52), (D, 0) ]
myGaps = [ (L, 0), (R, 0), (U, 52), (D, 0) ]
-- myGaps = [ (L, 160), (R, 160), (U, 127), (D, 127) ]

cycleGaps :: GapSpec -> GapSpec
cycleGaps gs = if gs == noGaps then myGaps else noGaps

myLayout = minimize . BW.boringWindows 
  $ lessBorders OnlyFloat 
  $ gaps myGaps 
  $ mySpacing 
  $ tiled
 where 
  mySpacing = spacingRaw False (Border 8 8 8 8) True (Border 8 8 8 8) True 

  tiled = Tall nmaster delta ratio
  nmaster = 1
  ratio = 2/3
  delta = 3/100

myKeys conf@(XConfig { modMask = modm }) = M.fromList $ 
  [ ((modm, xK_Return), spawn $ terminal conf)
  , ((modm, xK_p), spawn "rofi -show drun")
  , ((modm, xK_w), kill)
  , ((modm, xK_t), spawn "eww open powermenu")
  , ((modm, xK_c), spawn $ unwords [terminalExec, editor, configDir])

  , ((modm              , xK_m), windows W.focusMaster)
  , ((modm              , xK_j), windows W.focusDown)
  , ((modm              , xK_k), windows W.focusUp)
  , ((modm .|. shiftMask, xK_m), windows W.swapMaster)
  , ((modm .|. shiftMask, xK_j), windows W.swapDown)
  , ((modm .|. shiftMask, xK_k), windows W.swapUp)
  , ((modm              , xK_h), sendMessage Shrink)
  , ((modm              , xK_l), sendMessage Expand)
  , ((modm              , xK_n), withFocused minimizeWindow)
  , ((modm .|. shiftMask, xK_n), withLastMinimized maximizeWindow)

  -- Gaps
  , ((modm .|. controlMask, xK_g), sendMessage $ ModifyGaps cycleGaps)
  , ((modm .|. controlMask, xK_t), sendMessage $ IncGap 10 L)
  , ((modm .|. shiftMask, xK_t), sendMessage $ DecGap 10 L)
  , ((modm .|. controlMask, xK_y), sendMessage $ IncGap 10 D)
  , ((modm .|. shiftMask, xK_y), sendMessage $ DecGap 10 D)
  , ((modm .|. controlMask, xK_u), sendMessage $ IncGap 10 U)
  , ((modm .|. shiftMask, xK_u), sendMessage $ DecGap 10 U)
  , ((modm .|. controlMask, xK_i), sendMessage $ IncGap 10 R)
  , ((modm .|. shiftMask, xK_i), sendMessage $ DecGap 10 R)

  -- Audio keys
  , ((modm, xK_v), spawn "pactl set-sink-volume 0 -5%")
  , ((modm .|. shiftMask, xK_v), spawn "pactl set-sink-volume 0 +5%")
  -- , ((modm, xK_v), submap . M.fromList $
  --     [ ((modm, xK_k), spawn "pactl set-sink-volume 0 +5%")
  --     , ((modm, xK_j), spawn "pactl set-sink-volume 0 -5%")
  --     ])
  , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume 0 +5%")
  , ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume 0 -5%")
  , ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute 0 toggle")
  , ((0, xF86XK_AudioMicMute), spawn "pactl set-source-mute 1 toggle")

  -- Brightness keys
  , ((0, xF86XK_MonBrightnessUp), spawn "brightnessctl set +5")
  , ((0, xF86XK_MonBrightnessDown), spawn "brightnessctl set 5-")

  -- Workspace 0
  , ((modm, xK_0), do
      windows $ W.greedyView "0"
    )
  ]
  ++
  [ ((m .|. modm, k), windows $ f i) 
      | (i, k) <- zip (workspaces conf) [xK_1 .. xK_9]
      , (f, m) <- [ (W.greedyView, 0), (W.shift, shiftMask) ]
  ]

myConfig = def
  { modMask            = mod4Mask
  , keys               = myKeys
  , borderWidth        = myBorderWidth
  , focusedBorderColor = myFocusedBorderColor
  , layoutHook         = myLayout
  , manageHook         = myManageHook
  , normalBorderColor  = myNormalBorderColor 
  , startupHook        = myStartupHook
  , terminal           = myTerminal
  , workspaces         = myWorkspaces
  } 

main :: IO ()
main = xmonad $ fullscreenSupport $ docks $ ewmh myConfig
