#!/bin/bash

ns="passthrough"
setIPV4=$(cat /proc/sys/net/ipv4/ip_forward)

# Usage: ip link show | getInterfaces
getInterfaces() {
	if test ! -t 0; then
		cat < /dev/stdin | sed -rn 's/^[[:digit:]]+: (.*): .*$/\1/p' | sed -rn 's/^((en|wlan).*)$/\1/p'
	else
		return 1
		echo "No standard input"
	fi
}

if [ $(id -u) -ne 0 ]; then
	echo "Need root permissions"
	exit 1
fi

control_c() {
	if [ -n "$macvlan" ];then
		ip netns exec "$ns" /usr/bin/dhcpcd -x "$macvlan"
	fi
	ip netns pids "$ns" | xargs -r kill
	ip netns delete "$ns"
	sysctl -w net.ipv4.ip_forward=$setIPV4
	exit
}
trap control_c SIGINT
trap control_c SIGTERM

sysctl -w net.ipv4.ip_forward=1

echo "Creating namespace $ns"
ip netns add "$ns"
ip -n "$ns" link set lo up

# This only sets it up for the ethernet, this should be dynamic based on the link in future.
ethLink="$(ip link | getInterfaces | sed -rn 's/^((en).*)$/\1/p' | head)"
macvlan="mv-$ethLink"

echo "Creating macvlan $macvlan"
ip link add "$macvlan" link "$ethLink" type macvlan mode bridge
ip link set "$macvlan" netns "$ns"
echo "Setting $macvlan up"
ip -n "$ns" link set "$macvlan" up

# Start dhcpcd client
ip netns exec "$ns" /usr/bin/dhcpcd "$macvlan" &
# This portion is only needed while we don't have DHCP, I cannot be fucked with DHCP

# copy default route from normal space
# should also find the device to make sure it matches, but we assume it's always ethernet for now.
#gateway=$(ip route show default | sed -rn 's/^default via (.*) dev.*$/\1/p')
#assignedIP="192.168.0.31/24"

#ip -n "$ns" addr add "$assignedIP" dev "$macvlan"
#ip -n "$ns" route add default via "$gateway" dev "$macvlan"

#end

#end

# Wait forever
echo "Done, wait forever"
tail -f /dev/null
