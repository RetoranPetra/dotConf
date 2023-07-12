#!/bin/zsh
if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  source "/home/retoran/.env/wayland.zsh"
	sway
fi
