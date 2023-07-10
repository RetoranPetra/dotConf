#!/bin/zsh
hypr="$(zsh ~/.scripts/isHypr.sh)"
refresh=$1
if [[ $hypr == 1 ]];then
  hyprctl "keyword monitor DP-1,2560x1440@$refresh,0x0,1"
else
  #TODO: Add sway command that does this.
  echo "done!"
fi
