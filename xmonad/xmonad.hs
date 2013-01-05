import XMonad
import XMonad.Config.Gnome
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders   ( noBorders, smartBorders )
import XMonad.Layout.ToggleLayouts
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import Graphics.X11.ExtraTypes.XF86

myManageHook = composeAll
     [ className =? "Gimp"      --> doFloat
      , className =? "Vncviewer" --> doFloat
    ]
	
main = do
     xmproc <- spawnPipe "/usr/bin/xmobar"
     xmonad $ defaultConfig
        { borderWidth        = 5
        , terminal           = "gnome-terminal"
        , normalBorderColor  = "#666"
        , focusedBorderColor = "#ff0"
        , manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
        , layoutHook = avoidStruts ( layoutHook defaultConfig ) ||| (noBorders Full)
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
	, modMask = mod4Mask
	} `additionalKeys`
        [ ((controlMask, xK_Print), spawn "sleep 0.1; scrot -s")
        , ((0, xK_Print), spawn "scrot")
	, ((0, xF86XK_MonBrightnessUp),    spawn "xbacklight +10")
	, ((0, xF86XK_MonBrightnessDown),    spawn "xbacklight -10")
	, ((0, xF86XK_AudioLowerVolume),    spawn "pactl set-sink-volume 0 -- -10%")
	, ((0, xF86XK_AudioRaiseVolume),    spawn "pactl set-sink-volume 0 -- +10%")
	, ((0, xF86XK_AudioMute),    spawn "~/dotfiles/pavolcontrol toggle")
	, ((mod4Mask .|. shiftMask, xK_l),    spawn "xscreensaver-command -l") -- Lock Screen
	, ((mod4Mask .|. shiftMask, xK_s),   spawn "xscreensaver-command -l; pmi action suspend")
	, ((mod4Mask, xK_c),   spawn "chromium-browser")
	, ((mod4Mask, xK_t),   spawn "thunderbird")
	, ((mod4Mask, xK_n),   spawn "nautilus --no-desktop")
	, ((mod4Mask, xK_w),   spawn "VBoxManage startvm SS9_ghost") -- _W_indows
	, ((mod4Mask, xK_Return),   spawn "gnome-terminal")
	, ((mod4Mask .|. shiftMask .|. mod1Mask, xK_q), spawn "dbus-send --session --type=method_call --dest=org.gnome.SessionManager /org/gnome/SessionManager org.gnome.SessionManager.Logout uint32:1") -- Logout
	]