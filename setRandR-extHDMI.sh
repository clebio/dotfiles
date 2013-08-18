xrandr -q | grep "HDMI1 discon"
if [ $? == 1 ] 
then
    xrandr --output LVDS1 --mode 1600x900 --scale 1.2x1.2 --output HDMI1 --auto
else
    echo "mode 1600x900, scale 1x1"
    xrandr --output LVDS1 --mode 1600x900 --scale 1x1 --output HDMI1 --off
fi
