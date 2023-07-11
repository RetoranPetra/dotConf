#!/bin/zsh
systemctl --user import-environment XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd XDG_CURRENT_DESKTOP=sway
