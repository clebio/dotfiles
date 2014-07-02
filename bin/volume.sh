#!/bin/bash

# Prints volume changes to stdout.  
# Depends on inotify-tools package

SOUND_DEV="/dev/snd/controlC0"

# this should grab the field with the percentage.  maybe break on " " and grep line with %?
volume() {
    pactl list sinks \
	| grep Volume \
	| tail -2 \
	| head -1 \
	| sed 's/ //g' \
	| cut -d ':' -f 3 \
	| cut -d '%' -f 1
}

muting() {
    mute_state=$(pactl list sinks | grep Mute | tail -1 | sed 's/.*\(yes\).*/\1/')

    if [[ $mute_state == 'yes' ]]
	then
	echo '<fc=red>Muted</fc>'
	else
	echo ''
    fi
}

volume_n() {
    volume | tr -d "%" 
}

echo "<fc=yellow>Volume: $(volume_n)%</fc> $(muting)"
