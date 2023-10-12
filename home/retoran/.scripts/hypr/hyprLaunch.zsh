#!/bin/zsh
source "$HOME/.env/wayland.zsh"
export WLR_DRM_DEVICES="/dev/dri/card1"
exec Hyprland
