#!/bin/sh
curl -L https://serverlist.piaservers.net/vpninfo/servers/v6 | sed '1q' | jq '. | .regions[]| .name + ":" + .id' -r
