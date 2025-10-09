#!/bin/zsh
source "$HOME/.env/wayland.zsh"
export WLR_DRM_DEVICES="/dev/dri/card1"
export XDG_SESSION_DESKTOP="Hyprland"
export XDG_SESSION_TYPE="wayland"
export XDG_CURRENT_DESKTOP="Hyprland"
exec Hyprland
