#!/bin/sh
grim -g "$(slurp)" - | tesseract - - -l jpn+eng | sed 's/ //g' | wl-copy
