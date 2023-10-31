#!/bin/zsh
killall -e xdg-desktop-portal-wlr
waybar -c "/home/retoran/.config/hypr/waybar/config" &
hyprpaper &
wl-paste -t text --watch clipman store --no-persist &
mako --output DP-1&
source ~/.scripts/myDex.zsh &
thunar --daemon &
source "/home/retoran/.scripts/aerox9.zsh" &
source "/home/retoran/.scripts/mount.zsh" &
