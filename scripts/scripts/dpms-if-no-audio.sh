#!/bin/bash

if playerctl --all-players status 2>/dev/null | grep -q Playing; then
    exit 0
fi

hyprctl dispatch dpms off
