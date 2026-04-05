#!/bin/zsh
source /home/retoran/.env/javanoparent.zsh
source /home/retoran/.env/fcitx5.zsh
source /home/retoran/.env/grim.zsh
source /home/retoran/.env/bluetooth.sh
#QT
export QT_QPA_PLATFORM="wayland;xcb"
#export QT_QPA_PLATFORM=wayland
# Unifies QT based on the currenty GTK theme.
export QT_QPA_PLATFORMTHEME=gtk3
#SDL
export SDL_VIDEODRIVER="wayland,x11,*"
# PROTON/WINE
export PROTON_ENABLE_WAYLAND=1

#XDG
# Firefox wayland environment variable
export MOZ_ENABLE_WAYLAND=1
# Need to specify vdpau driver or it'll try to use the old nvidia one.
export LIBVA_DRIVER_NAME=radeonsi
export VDPAU_DRIVER=radeonsi
export WLR_DRM_DEVICES="/dev/dri/card1"

#New vars, may not be good.
#export WLR_RENDERER=vulkan
#export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
#export XWAYLAND_NO_GLAMOR=1
