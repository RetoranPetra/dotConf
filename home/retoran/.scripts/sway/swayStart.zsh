#!/bin/zsh
for f in ~/.env/*; do source $f; done
piactl connect
bazsh ~/.scripts/mount.sh
bazsh ~/.scripts/deskStart.sh
mako
