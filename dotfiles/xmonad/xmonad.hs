import XMonad
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks (docks, manageDocks, avoidStruts)
import XMonad.Hooks.Modal
import XMonad.Actions.Minimize
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen (fullscreenSupport, fullscreenManageHook)
import XMonad.Layout.Gaps (GapSpec, GapMessage (..), Direction2D (..), gaps)
import XMonad.Layout.Spacing (Border (Border), spacingRaw)
import XMonad.Util.SpawnOnce (spawnOnce)

import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import Data.Maybe
import Control.Monad
import XMonad.Layout.Renamed

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

addNETSupported :: Atom -> X ()
addNETSupported x   = withDisplay $ \dpy -> do
    r               <- asks theRoot
    a_NET_SUPPORTED <- getAtom "_NET_SUPPORTED"
    a               <- getAtom "ATOM"
    liftIO $ do
       sup <- join . maybeToList <$> getWindowProperty32 dpy a_NET_SUPPORTED r
       unless (fromIntegral x `elem` sup) $
         changeProperty32 dpy r a_NET_SUPPORTED a propModeAppend [fromIntegral x]

addEWMHFullscreen :: X ()
addEWMHFullscreen   = do
    wms <- getAtom "_NET_WM_STATE"
    wfs <- getAtom "_NET_WM_STATE_FULLSCREEN"
    mapM_ addNETSupported [wms, wfs]

myManageHook = fullscreenManageHook <+> manageDocks <+> insertPosition Below Newer <+> composeAll
  [ isFullscreen --> doFullFloat
  ]

myStartupHook :: X ()
myStartupHook = do
  spawn     "xset r rate 200 40"
  spawn     "xsetroot -cursor_name left_ptr"
  spawnOnce "feh --bg-scale ~/wallpapers/street.jpg"
  spawnOnce "eww daemon && eww open-many workspace-side time-side sys-side"
  spawnOnce "dunst"
  spawnOnce "dunstctl set-paused true"
  spawnOnce "picom"

noGaps = [ (L, 0), (R, 0), (U, 0), (D, 0) ]
myGaps = [ (L, 0), (R, 0), (U, 52), (D, 0) ]
-- myGaps = [ (L, 160), (R, 160), (U, 127), (D, 127) ]

cycleGaps :: GapSpec -> GapSpec
cycleGaps gs = if gs == noGaps then myGaps else noGaps

myLayout = -- minimize . BW.boringWindows
  avoidStruts
  $ mySpacing (gaps myGaps tiled) ||| noSpacing (noBorders $ gaps noGaps Full)
 where
  noSpacing = spacingRaw False (Border 0 0 0 0) True (Border 0 0 0 0) True
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
  , ((modm, xK_c), spawn $ unwords [terminalExec, configDir])

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
  , ((modm              , xK_space), sendMessage NextLayout)

  , ((modm, xK_b), setMode "bright")
  , ((modm ,xK_r), setMode "resize")
  , ((modm, xK_s), setMode "spotify")
  , ((modm, xK_v), setMode "vol")

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

brightMode :: Mode
brightMode = mode "bright" $ \_ ->
  M.fromList [ ((0, xK_k), spawn "brightnessctl set +5")
             , ((0, xK_j), spawn "brightnessctl set 5-")
             ]

resizeMode :: Mode
resizeMode = mode "resize" $ \_ ->
  M.fromList [ ((0, xK_r), sendMessage $ ModifyGaps cycleGaps)
             , ((0, xK_h), setMode "resize.left" )
             , ((0, xK_j), setMode "resize.bottom")
             , ((0, xK_k), setMode "resize.top")
             , ((0, xK_l), setMode "resize.right" )
             ]

resizeLeftMode :: Mode
resizeLeftMode = mode "resize.left" $ \_ ->
  M.fromList [ ((0, xK_h), sendMessage $ DecGap 10 L)
             , ((0, xK_l), sendMessage $ IncGap 10 L)
             , ((0, xK_b), setMode "resize")
             ]

resizeBottomMode :: Mode
resizeBottomMode = mode "resize.bottom" $ \_ ->
  M.fromList [ ((0, xK_j), sendMessage $ DecGap 10 D)
             , ((0, xK_k), sendMessage $ IncGap 10 D)
             , ((0, xK_b), setMode "resize")
             ]

resizeTopMode :: Mode
resizeTopMode = mode "resize.top" $ \_ ->
  M.fromList [ ((0, xK_k), sendMessage $ DecGap 10 U)
             , ((0, xK_j), sendMessage $ IncGap 10 U)
             , ((0, xK_b), setMode "resize")
             ]

resizeRightMode :: Mode
resizeRightMode = mode "resize.right" $ \_ ->
  M.fromList [ ((0, xK_l), sendMessage $ DecGap 10 R)
             , ((0, xK_h), sendMessage $ IncGap 10 R)
             , ((0, xK_b), setMode "resize")
             ]

spotifyMode :: Mode
spotifyMode = mode "spotify" $ \_ ->
  M.fromList [ ( (0, xK_k)
               , spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause"
               )
             , ( (0, xK_j)
               , spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous"
               )
             , ( (0, xK_l)
               , spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next"
               )
             ]

volMode :: Mode
volMode = mode "vol" $ \_ ->
  M.fromList [ ((0, xK_k), spawn "pactl set-sink-volume 0 +5%")
             , ((0, xK_j), spawn "pactl set-sink-volume 0 -5%")
             , ((0, xK_m), spawn "pactl set-sink-mute 0 toggle")
             , ((0, xK_n), spawn "pactl set-sink-mute 1 toggle")
             ]

myConfig = def
  { modMask            = mod4Mask
  , keys               = myKeys
  , borderWidth        = myBorderWidth
  , focusedBorderColor = myFocusedBorderColor
  , layoutHook         = myLayout
  , manageHook         = myManageHook
  , normalBorderColor  = myNormalBorderColor
  , startupHook        = myStartupHook >> addEWMHFullscreen
  , terminal           = myTerminal
  , workspaces         = myWorkspaces
  }

main :: IO ()
main = xmonad
  $ modal [ brightMode
          , resizeMode
          , resizeLeftMode
          , resizeTopMode
          , resizeBottomMode
          , resizeRightMode
          , spotifyMode
          , volMode
          ]
  $ fullscreenSupport
  $ docks
  $ ewmh myConfig
