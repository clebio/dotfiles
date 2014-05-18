#!/bin/bash
#set -x 
foo=`xrandr | grep eDP1`
lvds=`echo $foo | cut -d' ' -f1`
size=`echo $foo | cut -d' ' -f4 | cut -d '+' -f1`
max_size=`xrandr | grep -A 1 eDP1 | tail -1 | sed 's/[ ]+/ /g' | cut -d ' ' -f2`

if   [ $1 ]
then
    xrandr --output $lvds --scale ${1}x${1}
elif [ $2 ]
then
    xrandr --output $lvds --scale ${1}x${2}
elif [ "$size" == "$max_size" ]
then
    xrandr --output $lvds --scale 1.15x1.15
else
    xrandr --output $lvds --scale 1x1
fi
 
echo Previous scaled resolution: $size
 

# To find out your modes and such 
#
# run: cvt 1920 1080 # enter in the Width and Height you want (1440 900, 1366 768, whatever)
# # (outputs)
# # 1920x1080 59.96 Hz (CVT 2.07M9) hsync: 67.16 kHz; pclk: 173.00 MHz
# Modeline "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
#
# run: cvt 1920 1080 # enter in the Width and Height you want (1440 900, 1366 768, whatever)
# # (outputs)
# # 1024x600 59.85 Hz (CVT) hsync: 37.35 kHz; pclk: 49.00 MHz
# Modeline "1024x600_60.00"   49.00  1024 1072 1168 1312  600 603 613 624 -hsync +vsync
#
# run: xrandx  # note what the external display is called. For my setup, it's called: VGA . Use that in the following commands
