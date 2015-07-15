#!/bin/bash

DEVICE="ATML3000:00 03EB:8D02 UNKNOWN"

ABLE=$(xinput --list "${DEVICE}" | grep disabled)
if [ -z "${ABLE}" ]
then
    xinput --disable "${DEVICE}"
else
    xinput --enable "${DEVICE}"
fi

