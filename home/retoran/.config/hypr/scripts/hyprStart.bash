#!/bin/bash
hyprexec() {
    hyprctl dispatch "exec $@"
}

# https://klotzandrew.com/blog/parallel-bash-with-wait

# Tell systemd we're a graphical session so that related services run.
hyprexec killall -e xdg-desktop-portal-wlr
hyprexec source systemctl --user start hyprland-session.target

# Start up our wanted programs
hyprexec "waybar -c ~/.config/hypr/waybar/config"
hyprexec "hyprpaper"
hyprexec "wl-paste -t text --watch clipman store --no-persist"
hyprexec "mako --output DP-1"
hyprexec "source ~/.scripts/myDex.zsh"
hyprexec "thunar --daemon"
hyprexec "source ~/.scripts/aerox9.zsh"
hyprexec "source ~/.scripts/mount.zsh"

