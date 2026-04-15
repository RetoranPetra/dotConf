#!/usr/bin/env bash
newFile="${1%.gif}.mp4"
ffmpeg -i "$1" -pix_fmt yuv420p -vf 'scale=trunc(iw/2)*2:trunc(ih/2)*2' "$newFile" -y
err=$?
if [ $err -ne 0 ]; then
	exit $err
fi
touch -r "$1" "$newFile" && rm "$1"
exit $?
