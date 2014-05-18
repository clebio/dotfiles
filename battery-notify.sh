#!/bin/bash
BATTERY_CHARGE=$(acpi -b | sed -n 's/.*Discharging, \([0-9]\)%.*/\1/p')

if [ -n "${BATTERY_CHARGE}" ]
then
    if [ "${BATTERY_CHARGE}" -le "5" ]
    then
        zenity --warning --width=500 --height=300 --text="Battery critically low!"
    #    poweroff
    else 
        notify-send "Battery critically low: ${BATTERY_CHARGE}"
    fi
fi


