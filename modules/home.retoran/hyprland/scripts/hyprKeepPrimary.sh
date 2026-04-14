#!/bin/sh

primaryMonitor="$1";

xrandr --output "${primaryMonitor}" --primary

handle() {
	case $1 in "monitoradded>>${primaryMonitor}")
		echo "Setting ${primaryMonitor} to primary with xrandr"
		xrandr --output "${primaryMonitor}" --primary
	esac
}

socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock" | while read -r line; do handle "$line"; done
