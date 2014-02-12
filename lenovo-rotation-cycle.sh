#!/bin/bash
state=$(xrandr -q | grep eDP1 | cut -d ' ' -f 5 | sed 's/(//')

# rotate clock-wise
case "${state}" in
normal)
	# go right
	xrandr -o right
	xinput set-prop 'ELAN Touchscreen' 'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1
	;;
inverted)
	# go left
	xrandr -o left
	xinput set-prop 'ELAN Touchscreen' 'Coordinate Transformation Matrix' 0 -1 1 1 0 0 0 0 1
	;;
left)
	#go normal
	xrandr -o normal
	xinput set-prop 'ELAN Touchscreen' 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1
	;;
right)
	# go inverted
	xrandr -o inverted
	xinput set-prop 'ELAN Touchscreen' 'Coordinate Transformation Matrix' -1 0 1 0 -1 1 0 0 1
	;;
esac
