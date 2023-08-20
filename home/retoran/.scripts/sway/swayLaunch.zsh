#!/bin/zsh
source "/home/retoran/.env/wayland.zsh"
export XDG_CURRENT_DESKTOP=sway
sway -d 2> ~/sway.log
