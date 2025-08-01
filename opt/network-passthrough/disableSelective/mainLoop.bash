#!/bin/bash
ns="passthrough"
ipforward="$(cat /proc/sys/net/ipv4/conf/all/forwarding)"
vethbase="send-pass"
vethpeer="recieve-pass"

if [ $(id -u) -ne 0 ]; then
	echo "Need root permissions"
	exit 1
fi

cleanup() {
	ip netns pids "$ns" | xargs -r kill
	ip netns delete "$ns"
	sysctl -w net.ipv4.conf.all.forwarding="$ipforward"
}
trap cleanup SIGINT
trap cleanup SIGTERM

ln -fs /run/systemd/resolve/resolv.conf /etc/netns/passthrough/resolv.conf
rm /etc/netns/passthrough/resolv.conf
echo "9.9.9.9" > /etc/netns/passthrough/resolv.conf

ip netns add "$ns"
ip -n "$ns" link set lo up

ip link add "$vethbase" type veth peer name "$vethpeer" netns "$ns"
ip addr add 10.100.100.32/31 dev "$vethbase"
ip link set "$vethbase" up

ip -n "$ns" addr add 10.100.100.33/31 dev "$vethpeer"
ip -n "$ns" link set "$vethpeer" up

ip -n "$ns" route add default via 10.100.100.32
ip rule add from 10.100.100.33 table main priority 99

sysctl -w net.ipv4.conf.all.forwarding=1

nft -f /etc/nftables.d/passthrough-disableSelective.conf

tail -f /dev/null
