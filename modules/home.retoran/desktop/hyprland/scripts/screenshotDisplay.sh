#!/bin/sh
monitor="$(hyprctl monitors -j | jq -r '.[] | select(.focused).name')"
grim -o "$monitor" - | wl-copy
grim -g "$monitor"
notify-desktop "Grim" "Snapped Display"
