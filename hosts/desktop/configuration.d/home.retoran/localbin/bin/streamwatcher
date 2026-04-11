#!/bin/bash
username=$1
url="https://twitch.tv/${username}"
quality="best"

while true; do
	echo "Waiting for stream at ${url}"
	until streamlink -o "~/Videos/StreamArchive/$(date -u --iso-8601=minutes | sed -r -e 's/:/_/g' -e 's/\+.*$//')${username}.mp4" "${url}" "${quality}"; do
		sleep 30
	done;
	echo "Finished archiving stream from ${url}"
done

