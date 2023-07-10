#!/bin/zsh
if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  source "$HOME/.env/wayland.zsh"
	exec sway
fi
