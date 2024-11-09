#!/bin/bash
command="waybar -c $HOME/.config/hypr/waybar/config.jsonc"
while sleep 5; do
    processes=$(pgrep -f "$command")
    if [ $? = 1 ]; then
        hyprctl dispatch exec "$command" &
    fi;
    numberOfProcesses=$(echo "$processes" | wc -l)

    if [ "$numberOfProcesses" != 1 ]; then
        pkill "$command" -f
        hyprctl dispatch exec "$command" &
    fi
done;
