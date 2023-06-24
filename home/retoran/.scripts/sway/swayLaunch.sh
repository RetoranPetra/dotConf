#!/bin/bash
if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	source /home/retoran/.env/wayland.sh
	exec sway
fi
