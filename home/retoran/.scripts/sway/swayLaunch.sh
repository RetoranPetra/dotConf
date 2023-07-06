#!/bin/bash
if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  for f in ~/.env/*; do source $f; done
	exec sway
fi
