import XMonad
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks (docks, manageDocks)
import XMonad.Actions.Minimize
import XMonad.Layout.Minimize
import XMonad.Layout.NoBorders
import qualified XMonad.Layout.BoringWindows as BW
import XMonad.Layout.Fullscreen (fullscreenSupport)
import XMonad.Layout.Gaps (GapMessage (..), Direction2D (..), gaps, setGaps)
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

myTerminal :: String
myTerminal = "kitty"

myBorderWidth = 3

myFocusedBorderColor :: String
myFocusedBorderColor = "#45475a"

myNormalBorderColor :: String
myNormalBorderColor = "#313244"

myManageHook = manageDocks <+> composeAll
  [ --className =? "Eww" --> doFloat
  ]

myStartupHook :: X ()
myStartupHook = do
  spawn     "xset r rate 200 40"
  spawn     "xsetroot -cursor_name left_ptr"
  spawnOnce "feh --bg-scale ~/wallpapers/street.jpg"
  spawnOnce "dunst"
  spawnOnce "picom --experimental-backends"
  spawnOnce "eww daemon & eww open powermenu"

myGaps = [(L, 160), (R, 160), (U, 120), (D, 120)]

myLayout = minimize . BW.boringWindows $ lessBorders OnlyFloat $ gaps myGaps $ mySpacing $ tiled
  where 
    mySpacing = spacingRaw False (Border 10 10 10 10) True (Border 10 10 10 10) True 

    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 1/2
    delta = 3/100

myKeys conf@(XConfig { modMask = modm }) = M.fromList $ 
  [ ((modm, xK_Return), spawn $ terminal conf)
  , ((modm, xK_p), spawn "rofi -show drun")
  , ((modm, xK_w), kill)
  , ((modm, xK_t), spawn "eww open powermenu")

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
  , ((modm .|. controlMask, xK_g), sendMessage $ ToggleGaps)
  , ((modm .|. shiftMask, xK_g), sendMessage $ setGaps myGaps)
  , ((modm .|. controlMask, xK_t), sendMessage $ IncGap 10 L)
  , ((modm .|. shiftMask, xK_t), sendMessage $ DecGap 10 L)
  , ((modm .|. controlMask, xK_y), sendMessage $ IncGap 10 D)
  , ((modm .|. shiftMask, xK_y), sendMessage $ DecGap 10 D)
  , ((modm .|. controlMask, xK_u), sendMessage $ IncGap 10 U)
  , ((modm .|. shiftMask, xK_u), sendMessage $ DecGap 10 U)
  , ((modm .|. controlMask, xK_i), sendMessage $ IncGap 10 R)
  , ((modm .|. shiftMask, xK_i), sendMessage $ DecGap 10 R)

  -- Audio keys
  , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume 0 +5%")
  , ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume 0 -5%")
  , ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute 0 toggle")
  , ((0, xF86XK_AudioMicMute), spawn "pactl set-source-mute 1 toggle")

  -- Brightness keys
  , ((0, xF86XK_MonBrightnessUp), spawn "brightnessctl set +5")
  , ((0, xF86XK_MonBrightnessDown), spawn "brightnessctl set 5-")
  ]
  ++
  [ ((m .|. modm, k), windows $ f i) 
      | (i, k) <- zip (workspaces conf) [xK_1 .. xK_9]
      , (f, m) <- [ (W.greedyView, 0), (W.shift, shiftMask) ]
  ]

myConfig = def
  { modMask            = mod4Mask
  , keys               = myKeys
  , terminal           = myTerminal
  , borderWidth        = myBorderWidth
  , focusedBorderColor = myFocusedBorderColor
  , normalBorderColor  = myNormalBorderColor 
  , startupHook        = myStartupHook
  , layoutHook         = myLayout
  , manageHook         = myManageHook
  } 

main :: IO ()
main = xmonad $ fullscreenSupport $ docks $ ewmh myConfig
