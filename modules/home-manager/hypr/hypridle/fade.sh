#!/usr/bin/env bash

BRIGHTNESS_CACHE=$XDG_CACHE_HOME/brightness

if [ "$1" == "fade" ]; then
	brightness=$(cat /sys/class/backlight/*/brightness)
	echo "$brightness" >"$BRIGHTNESS_CACHE"

	for ((i = brightness; i >= 0; i--)); do
		brightnessctl s $i >/dev/null
		sleep 0.001
	done
elif [ "$1" == "resume" ]; then
	saved_brightness=$(<"$BRIGHTNESS_CACHE")
	rm "$BRIGHTNESS_CACHE"

	for ((i = 0; i <= saved_brightness; i++)); do
		brightnessctl s $i >/dev/null
		sleep 0.001
	done
fi
