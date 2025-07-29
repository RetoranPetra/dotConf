#!/bin/bash
ffmpeg -i "$1" -pix_fmt yuv420p -vf 'scale=trunc(iw/2)*2:trunc(ih/2)*2' "${1%.gif}.mp4" -y && rm "$1"
