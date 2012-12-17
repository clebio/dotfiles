#!/bin/bash
 
xrdb -merge .Xresources
feh --bg-fill /home/caleb/Pictures/20090131_Knob_Noster/ &
xscreensaver -no-splash &
trayer --edge top --align right --SetDockType true --SetPartialStrut true \
  --widthtype percent --width 10 --expand true --transparent true --tint 0x191970 --height 12 &
#~/.dropbox-dist/dropboxd &
#gajim &
synkron &
 
if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
fi
 
if [ -x /usr/bin/gnome-power-manager ] ; then
   sleep 3
   gnome-power-manager &
fi
 
exec xmonad
