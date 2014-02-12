#!/bin/bash

case "$1" in
normal)
	xrandr -o normal
	xinput set-prop 'ELAN Touchscreen' 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1
	;;
inverted)
	xrandr -o inverted
	xinput set-prop 'ELAN Touchscreen' 'Coordinate Transformation Matrix' -1 0 1 0 -1 1 0 0 1
	;;
left)
	xrandr -o left
	xinput set-prop 'ELAN Touchscreen' 'Coordinate Transformation Matrix' 0 -1 1 1 0 0 0 0 1
	;;
right)
	xrandr -o right
	xinput set-prop 'ELAN Touchscreen' 'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1
	;;
detouch)
	xinput disable "SynPS/2 Synaptics TouchPad"
	;;
retouch)
	xinput enable "SynPS/2 Synaptics TouchPad"
	;;
esac