#!/bin/bash

# Prints volume changes to stdout.  
# Depends on inotify-tools package

SOUND_DEV="/dev/snd/controlC0"

# this should grab the field with the percentage.  maybe break on " " and grep line with %?
volume() {
    amixer -D default sget Master,0 \
	  | grep % \
	  | sed -e 's/.*\[\(.\{1,3\}%\)\].*/\1/'  \
          | head -n 1
}

muting() {
    mute_state=$(amixer -D default sget Master,0 \
	| tail -n 1 \
	| sed -r 's/.*?(off|on).*/\1/' )

    if [[ $mute_state == 'on' ]]
	then
	echo ''
	else
	echo '<fc=red>Muted</fc>'
    fi
}

volume_n() {
    volume | tr -d "%" 
}

echo "<fc=yellow>Volume: $(volume_n)%</fc> $(muting)"
