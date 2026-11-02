#!/bin/bash

"$HOME/scripts/media-playing.sh" && exit 0
hyprctl dispatch 'hl.dsp.dpms({ action = "disable" })'
