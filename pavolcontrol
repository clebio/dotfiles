#!/bin/bash
# /usr/local/bin/pavolcontrol
#
# Copyright (C) 2012 Maze <maze@pkbd.org>
#
# pavolcontrol is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# pavolcontrol is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with pavolcontrol.  If not, see <http://www.gnu.org/licenses/>.

INCREMENT=5

function get_mute_status
{
        ISMUTE=0
        if ( pactl list sinks | grep Mute | tail -1 | grep yes ) ; then
                ISMUTE=1
        fi
}

function toggle_mute
{
        pactl set-sink-mute 1 toggle
}

function  get_cur_vol
{
        CURVOL=$( pactl list sinks | awk '/Volume: 0:/ {print substr($3, 1, index($3, "%") - 1)}' )
}

case "$1" in
increase)       get_cur_vol
                declare -i NEWVOL=$CURVOL+$INCREMENT
                pactl set-sink-volume 1 ${NEWVOL}"%"
                ;;
decrease)       get_cur_vol
                declare -i NEWVOL=$CURVOL-$INCREMENT
                pactl set-sink-volume 1 ${NEWVOL}"%"
                ;;
toggle)         toggle_mute
                ;;
*)              echo "Usage: /usr/local/bin/pavolctrl {increase|decrease|toggle}"
                exit 2
                ;;
esac
exit 0