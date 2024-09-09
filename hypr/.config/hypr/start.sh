#! /usr/bin/env bash

swww-daemon &
# swww img ~/Wallpapers/gruvbox-mountain-village.png

nm-applet --indicator & # Wifi GUI

waybar & # Top-bar

mako # Notification

pypr &
hyprpaper & # Background
poweralertd &
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
wl-clip-persist --clipboard regular &
avizo-service &

