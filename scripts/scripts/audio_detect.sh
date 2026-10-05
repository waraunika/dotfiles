#!/bin/bash

for player in $(playerctl -l); do
    status=$(playerctl -p "$player" status 2>/dev/null)

    [[ "$status" != "Playing" ]] && continue

    case "$player" in
        firefox|chromium|google-chrome|mpv|vlc)
            exit 0    # video player running
            ;;
    esac
done

exit 1
