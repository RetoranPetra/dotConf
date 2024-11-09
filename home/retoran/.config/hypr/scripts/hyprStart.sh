#!/bin/sh
# https://klotzandrew.com/blog/parallel-bash-with-wait

# Tell systemd we're a graphical session so that related services run.
killall -e xdg-desktop-portal-wlr > /dev/null>&1 &
systemctl --user start hyprland-session.target > /dev/null 2>&1

# Start up our wanted programs
hyprpaper > /dev/null 2>&1 &
copyq --start-server > /dev/null 2>&1 &
mako --output DP-1 > /dev/null 2>&1 &
thunar --daemon > /dev/null 2>&1 &
zsh ~/.scripts/myDex.zsh > /dev/null 2>&1 &
# Should be called somewhere else probably
zsh ~/.scripts/mount.zsh > /dev/null 2>&1 &

