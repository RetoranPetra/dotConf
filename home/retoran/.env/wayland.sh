#!/bin/sh

#Clutter
export CLUTTER_BACKEND=wayland
#QT
#export QT_QPA_PLATFORM="wayland;xcb"
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt5ct
#SDL
#export SDL_VIDEODRIVER="wayland,x11"
export SDL_VIDEODRIVER=wayland
export GDK_BACKEND=wayland
#XDG
export XDG_SESSION_TYPE=wayland

#Nvidia compatibility
export LIBVA_DRIVER_NAME=nvidia
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export WLR_NO_HARDWARE_CURSORS=1
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export __GL_GSYNC_ALLOWED=1
