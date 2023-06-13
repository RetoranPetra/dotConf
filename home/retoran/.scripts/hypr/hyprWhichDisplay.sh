#!/bin/bash
#All of this is cursed
#file="/tmp/hyprWhichDisplay.txt"
#hyprctl monitors > $file
#lineNum="$(grep "focused: yes" $file -n | cut -d: -f1)"
#echo "$lineNum"
#monitorLine="$((lineNum-10))"
#monitor=$(sed "$monitorLine"q\;d $file)
##monitor=$(sed -e 's/Monitor //' <<< "$monitor")
##monitor=$(sed -e 's/ (ID [0-9])://' <<< "$monitor")
#monitor=$(sed -e 's/(Monitor )|( (ID [0-9]):)//' <<< "$monitor")
#echo "$monitor"
hyprctl monitors -j | jaq -r '.[] | select(.focused).name'
