#!/bin/zsh
killall -e xdg-desktop-portal-wlr
waybar &
hyprpaper &
wl-paste -t text --watch clipman store --no-persist &
mako &
source ~/.scripts/myDex.zsh &
thunar --daemon &
source "/home/retoran/.scripts/aerox9.zsh" &
source "/home/retoran/.scripts/mount.zsh" &
