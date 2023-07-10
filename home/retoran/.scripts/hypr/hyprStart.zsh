#!/bin/zsh
piactl connect
waybar &
hyprpaper &
mako &
./usr/lib/polkit-kde-authentication-agent-1 &
bazsh ~/.scripts/mount.sh &
bazsh ~/.scripts/deskStart.sh
