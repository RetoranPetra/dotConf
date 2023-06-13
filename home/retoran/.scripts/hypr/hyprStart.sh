#!/bin/bash
piactl connect
waybar &
hyprpaper &
mako &
./usr/lib/polkit-kde-authentication-agent-1 &
bash ~/.scripts/mount.sh &
bash ~/.scripts/deskStart.sh
