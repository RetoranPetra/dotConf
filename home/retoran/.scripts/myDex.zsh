#!/bin/zsh
# Blacklist KDE execs.
dex .config/autostart/* $(find /etc/xdg/autostart/* ! '(' -name 'baloo_file.desktop' -o -name 'geoclue-demo-agent.desktop' -o -name 'klipper.desktop' -o -name 'org.kde.plasmashell.desktop' -o -name 'xembedsniproxy.desktop' -o -name 'powerdevil.desktop' -o -name 'kaccess.desktop' ')')
