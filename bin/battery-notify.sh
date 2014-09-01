#!/bin/bash
BATTERY_CHARGE=$(acpi -b | sed -n 's/.*Discharging, \([0-9]*\)%.*/\1/p')

if [ -n "${BATTERY_CHARGE}" ]
then
    if [ "${BATTERY_CHARGE}" -le "5" ]
    then
        /usr/bin/zenity --warning --width=500 --height=300 --text="Battery critically low!"
    #    poweroff
    elif [ "${BATTERY_CHARGE}" -le "10" ]
    then
        /usr/bin/notify-send "Battery low: ${BATTERY_CHARGE}"
    fi
fi

