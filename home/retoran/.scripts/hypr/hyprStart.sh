#!/bin/sh

waybar -c ~/.config/hypr/waybar/config &
hyprpaper &
wl-paste -t text --watch clipman store --no-persist &
mako --output DP-1 &
source ~/.scripts/myDex.zsh &
thunar --daemon &
source ~/.scripts/aerox9.zsh &
source ~/.scripts/mount.zsh &
# Tell systemd we're a graphical session so that related services run.
killall -e xdg-desktop-portal-wlr
source systemctl --user start hyprland-session.target

