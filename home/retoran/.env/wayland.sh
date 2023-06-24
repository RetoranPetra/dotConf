#!/bin/sh

#Clutter
export CLUTTER_BACKEND=wayland
#QT
export QT_QPA_PLATFORM="wayland;xcb"
#export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt5ct
#SDL
export SDL_VIDEODRIVER="wayland,x11"
#export SDL_VIDEODRIVER=wayland
export GDK_BACKEND=wayland
#XDG
export XDG_SESSION_TYPE=wayland
# Firefox wayland environment variable
export MOZ_ENABLE_WAYLAND=1
export MOZ_USE_XINPUT2=1
# Need to specify vdpau driver or it'll try to use the old nvidia one.
export LIBVA_DRIVER_NAME=radeonsi

#Nvidia compatibility
#export LIBVA_DRIVER_NAME=nvidia
#export GBM_BACKEND=nvidia-drm
#export WLR_NO_HARDWARE_CURSORS=1
#export QT_AUTO_SCREEN_SCALE_FACTOR=1
#export __GL_GSYNC_ALLOWED=1
#export __GLX_VENDOR_LIBRARY_NAME=nvidia
#New vars, may not be good.
#export WLR_RENDERER=vulkan
#export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
#export XWAYLAND_NO_GLAMOR=1
