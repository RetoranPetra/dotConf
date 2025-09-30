#!/usr/bin/python3
import time
import openrazer.client

# This is a workaround for when you plug in a wired mouse while
# it's still connected wirelessly.

devman = openrazer.client.DeviceManager()

while len(devman.devices) < 2:
    time.sleep(0.5)
    devman = openrazer.client.DeviceManager()

for device in devman.devices:
    if "Basilisk" in device.name:
        device.dpi = (1200, 1200)
