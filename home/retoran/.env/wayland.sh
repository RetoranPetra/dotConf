#!/bin/sh

#Clutter
export CLUTTER_BACKEND=wayland
#QT
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt5ct
#SDL
export SDL_VIDEODRIVER=wayland
#XDG
export XDG_SESSION_TYPE=wayland

