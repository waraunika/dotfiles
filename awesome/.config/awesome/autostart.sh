#!/bin/sh
run() { pgrep -x "$1" >/dev/null || "$@" & }

~/scripts/idle apply
run xss-lock --transfer-sleep-lock --notifier="$HOME/scripts/lock-notify" -- "$HOME/scripts/lock"
run picom --experimental-backends --config ~/.config/picom/picom.conf
run clipmenud
run dunst
sct 4500
[ -x ~/.fehbg ] && ~/.fehbg

dev="ASUSTek TUF GAMING M5"
xinput set-button-map "$dev" $(xinput get-button-map "$dev" | awk '{ $8=10; $9=11; print }')

tp="ELAN1203:00 04F3:307A Touchpad"
xinput set-prop "$tp" "libinput Natural Scrolling Enabled" 1
xinput set-prop "$tp" "libinput Tapping Enabled" 1
