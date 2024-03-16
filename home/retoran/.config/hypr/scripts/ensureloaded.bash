#!/bin/bash
if [[ $(pgrep waybar) ]]; then
	echo "found waybar"
else
	echo "did not find waybar"
fi
