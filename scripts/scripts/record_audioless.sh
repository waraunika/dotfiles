#!/bin/bash

mkdir -p ~/Videos/Screenrecords

current_time=$(date "+%Y-%m-%d-%H%M%S")

FIXED_PID_FILE="/tmp/hypr_record.pid"
RECORDING_FILE="$HOME/Videos/Screenrecords/record_$current_time.mp4"

if [ -f "$FIXED_PID_FILE" ]; then
  kill $(cat "$FIXED_PID_FILE") 2>/dev/null
  rm "$FIXED_PID_FILE"
  notify-send "Recording stopped" "Vido Saved - $RECORDING_FILE"
else

  wf-recorder -g "$(slurp)" -f "$RECORDING_FILE" &
  echo $! >"$FIXED_PID_FILE"
  notify-send "Recording started" "Select area to record"
fi
