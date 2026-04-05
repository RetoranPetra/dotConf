#!/bin/bash
primaryMonitor="$1"
monitorFlag=1

while true; do
	sleep 1s
	if xrandr --listmonitors | grep "$primaryMonitor" > /dev/null; then
		if [ $monitorFlag -eq 1 ]; then
			xrandr --output "$primaryMonitor" --primary
			echo "Set primary monitor to $primaryMonitor"
			monitorFlag=0
		fi
	elif [ $monitorFlag -eq 0 ]; then
		echo "Primary monitor disconnected"
		monitorFlag=1
	fi
done
