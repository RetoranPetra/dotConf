#!/bin/bash
piactl connect
swaymsg output DP-2 transform 90 anticlockwise 
swaymsg "output DP-2 pos -1440 0"
bash ~/.scripts/mount.sh
bash ~/.scripts/deskStart.sh
