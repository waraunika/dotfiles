#!/bin/bash

killall -9 waybar
killall -9 swaync

waybar &
# 0 or 1
# 1 for integrated for current desktop
DRI_PRIME=1 swaync &
