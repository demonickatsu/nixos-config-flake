#!/bin/sh
# xrandr --output DVI-D-0 --mode 1280x720 --pos 1920x480 --rotate normal --output HDMI-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal &
picom &
feh --bg-fill ~/Backgrounds/nordnix1.png &
dunst &
kdeconnectd &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
