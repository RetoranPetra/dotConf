#!/bin/zsh
source "/home/retoran/.env/wayland.zsh"
export XDG_CURRENT_DESKTOP=sway
# Card1 is 7900 XTX.
export WLR_DRM_DEVICES="/dev/dri/card1"
sway -d 2> ~/sway.log
