#!/bin/sh
coords="$(slurp)"
grim -g "$coords" - | wl-copy
grim -g "$coords"
notify-desktop "Grim" "Snapped Monitor"
