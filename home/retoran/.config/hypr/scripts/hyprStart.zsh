#!/bin/zsh
hyprexec() {
    hyprctl dispatch "exec $@"
}

# https://klotzandrew.com/blog/parallel-bash-with-wait

# Tell systemd we're a graphical session so that related services run.
killall -e xdg-desktop-portal-wlr
source systemctl --user start hyprland-session.target

# Start up our wanted programs
hyprpaper
wl-paste -t text --watch clipman store --no-persist
waybar -c ~/.config/hypr/waybar/config
mako --output DP-1
thunar --daemon
source ~/.scripts/aerox9.zsh
source ~/.scripts/myDex.zsh
zsh ~/.scripts/mount.zsh

