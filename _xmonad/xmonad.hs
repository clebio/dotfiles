import XMonad
import XMonad.Config.Gnome
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders   ( noBorders, smartBorders )
import XMonad.Layout.ToggleLayouts
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ICCCMFocus
import System.IO
import Graphics.X11.ExtraTypes.XF86

myManageHook = composeAll
     [ className =? "Gimp"      --> doFloat
      , className =? "Vncviewer" --> doFloat
    ]
	
main = do
     xmproc <- spawnPipe "/usr/bin/xmobar"
     xmonad $ defaultConfig
        { borderWidth        = 3
        , terminal           = "gnome-terminal"
        , normalBorderColor  = "#666"
        , focusedBorderColor = "#ff0"
        , manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
        , layoutHook = avoidStruts ( layoutHook defaultConfig ) ||| (noBorders Full)
        , logHook = dynamicLogWithPP xmobarPP 
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 150
                        }
	, modMask = mod4Mask
	, startupHook = takeTopFocus >> setWMName "LG3D"
	} `additionalKeys`
        [ ((controlMask, xK_Print), spawn "sleep 0.1; scrot -s")
        , ((0, xK_Print), spawn "scrot")
	, ((controlMask, xK_F3),    spawn "xbacklight +10")
	, ((controlMask, xK_F2),    spawn "xbacklight -10")
	, ((controlMask, xK_F7),    spawn "pactl set-sink-volume 1 -- -10%")
	, ((controlMask, xK_F8),    spawn "pactl set-sink-volume 1 -- +10%")
	, ((controlMask, xK_F6),    spawn "~/dotfiles/pavolcontrol toggle")
	, ((mod4Mask .|. shiftMask, xK_l),    spawn "xscreensaver-command -l") -- Lock Screen
	, ((mod4Mask .|. shiftMask, xK_x),   spawn "xscreensaver-command -l; ~/bin/suspend.sh")
	, ((mod4Mask, xK_c),   spawn "chromium-browser")
	, ((mod4Mask .|. shiftMask, xK_b),   spawn "firefox")
	, ((mod4Mask, xK_m),   spawn "thunderbird")
	, ((mod4Mask, xK_n),   spawn "nautilus --no-desktop")
	, ((mod4Mask .|. controlMask, xK_w),   spawn "VBoxManage startvm 'Winders'") -- _W_indows
	, ((mod4Mask, xK_w),   spawn "VBoxManage controlvm  'Windows 7' savestate")
	, ((mod4Mask, xK_Return),   spawn "gnome-terminal")
	, ((mod4Mask .|. shiftMask, xK_p),   spawn "1P.sh")
	, ((mod4Mask .|. shiftMask .|. mod1Mask, xK_q), spawn "dbus-send --session --type=method_call --dest=org.gnome.SessionManager /org/gnome/SessionManager org.gnome.SessionManager.Logout uint32:1") -- Logout
	, ((mod4Mask .|. shiftMask, xK_d), spawn "~/dotfiles/lenovo-rotate.sh left")
	, ((mod4Mask .|. shiftMask, xK_w), spawn "~/dotfiles/lenovo-rotate.sh inverted")
	, ((mod4Mask .|. shiftMask, xK_a), spawn "~/dotfiles/lenovo-rotate.sh right")
	, ((mod4Mask .|. shiftMask, xK_s), spawn "~/dotfiles/lenovo-rotate.sh normal")
	, ((mod4Mask, xK_o), spawn "~/dotfiles/lenovo-rotation-cycle.sh")
	]
