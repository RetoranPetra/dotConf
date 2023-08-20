#!/bin/zsh
if [[ $XDG_CURRENT_DESKTOP == "sway" ]]; then
  swaymsg output DP-2 disable
  swaymsg output HDMI-A-1 disable
  swaymsg output DP-1 disable
  swaymsg output DP-1 enable
fi
