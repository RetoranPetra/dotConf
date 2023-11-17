#!/bin/zsh
source /home/retoran/.env/javanoparent.zsh
source /home/retoran/.env/fcitx5.zsh
source /home/retoran/.env/grim.zsh
#Clutter
export CLUTTER_BACKEND=wayland
#QT
export QT_QPA_PLATFORM="wayland;xcb"
#export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt5ct
#SDL
#Enforcing SDL to be wayland causes issues. Don't unless the game likes it.
#export SDL_VIDEODRIVER="wayland,x11"

#Don't need this, defaults to wayland by default. Enforcing may cause problems.
#export GDK_BACKEND=wayland
#XDG
export XDG_SESSION_TYPE=wayland
# Firefox wayland environment variable
export MOZ_ENABLE_WAYLAND=1
#export MOZ_USE_XINPUT2=1
# Need to specify vdpau driver or it'll try to use the old nvidia one.
export LIBVA_DRIVER_NAME=radeonsi
export VDPAU_DRIVER=radeonsi
export __EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json


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
