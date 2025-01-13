#!/bin/bash
if [[ -z $1 ]]; then
	echo "No device IP provided"
	exit
fi
control_c() {
	adb disconnect "$DEVICEIP:$FOUNDPORT" > /dev/null 2>&1
	exit
}
trap control_c SIGINT

DEVICEIP="$1"
while true; do
	echo "Waiting for device:$DEVICEIP to appear"
	until ping -c1 "$DEVICEIP" >/dev/null 2>&1; do sleep 5; done
	echo "$DEVICEIP responded to a ping"

	FOUNDPORT=$(adb devices | tail -n+2 | awk "{print \$1}" | cut -d: -f2)

	if [[ -z $FOUNDPORT ]] && ! [[ $(adb connect "$DEVICEIP:$FOUNDPORT") =~ .*connected.* ]]; then
		adb disconnect "$DEVICEIP:$FOUNDPORT" > /dev/null 2>&1

		while true; do
			DEVICEPORTS=$(nmap "$DEVICEIP" -p 37000-44000 | awk "/\/tcp/" | cut -d/ -f1)
			if [[ -n $DEVICEPORTS ]]; then break ; fi
			echo "Didn't find an open port, waiting."
			sleep 60
		done

		for port in $DEVICEPORTS; do
			if [[ $(adb connect "$DEVICEIP:$port") =~ .*connected.* ]]; then
				FOUNDPORT=$port
				break
			fi
		done
		echo "Failed to connect to $DEVICEIP:$port"
	fi
	echo "Connected to $DEVICEIP:$FOUNDPORT"
	until [[ "offline" = $(adb devices | awk "/$DEVICEIP:$FOUNDPORT/ {print \$2}") ]]; do sleep 5; done
	echo "Device offline"
done
