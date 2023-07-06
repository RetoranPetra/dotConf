#!/bin/bash
for f in ~/.env/*; do source $f; done
piactl connect
bash ~/.scripts/mount.sh
bash ~/.scripts/deskStart.sh
mako
