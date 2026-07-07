#!/bin/bash

while true; do
  notify-send "Take rest" "Time to take a break!" -u normal
  paplay /usr/share/sounds/freedesktop/stereo/bell.oga
  sleep 600 # 10 minutes (10 * 60 seconds)
done
