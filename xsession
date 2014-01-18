#!/bin/bash
 
if [ -f $HOME/.Xdefaults ]; then
  xrdb -merge $HOME/.Xdefaults
fi

feh --bg-fill $(find /data/Pictures/ -name "*.JPG" -print | sort -R | head -n 1) &
xscreensaver -no-splash &
trayer --edge top --align right --SetDockType true --SetPartialStrut false --widthtype percent --width 10 --expand true --transparent true --tint 0x191970 --height 18 &
bluetooth-applet &
~/.dropbox-dist/dropboxd &
#gajim &
synkron &
 
if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
fi
 
if [ -x /usr/bin/gnome-power-manager ] ; then
   sleep 3
   gnome-power-manager &
fi

alias 1P='wine /home/caleb/.wine/drive_c/Program\ Files\ \(x86\)/1Password/1Password.exe &'
 
exec xmonad
