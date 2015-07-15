#!/bin/bash
EXT=`xrandr | grep -E '(HDMI|VGA)' | cut -d ' ' -f 1`
INT=`xrandr | grep -E '(eDP|LVDS)' | cut -d ' ' -f 1`

if [ -n "$EXT" ]
then
    xrandr --output ${INT} --auto --output ${EXT} --auto
else
    xrandr --output ${INT} --auto --output ${EXT} --off
fi
