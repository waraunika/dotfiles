#!/usr/bin/sh
set -eu

LATENCY=125
PIPE_PATH="/tmp/scrcpy_mic_pipe"
SOURCE_NAME="ScrcpyMic"

cleanup() {
	if [ -n "${PAREC_PID:-}" ]; then
		kill "$PAREC_PID" 2>/dev/null || true
	fi
	if [ -n "${MODULE_ID:-}" ]; then
		pactl unload-module "$MODULE_ID" 2>/dev/null || true
	fi
	rm -f "$PIPE_PATH"
}
trap cleanup EXIT INT TERM

# Pre-cleanup leftovers from previous runs / reboots
pkill -f "parec --raw -d ${SOURCE_NAME}" 2>/dev/null || true
for id in $(pactl list short modules | awk -v n="$SOURCE_NAME" '$2=="module-pipe-source" && $0 ~ n {print $1}'); do
	pactl unload-module "$id" 2>/dev/null || true
done
rm -f "$PIPE_PATH"

# Create virtual mic
MODULE_ID=$(pactl load-module module-pipe-source \
	source_name="$SOURCE_NAME" \
	channels=2 format=s16 rate=48000 \
	file="$PIPE_PATH")

# Drain the pipe so scrcpy doesn't block
parec --raw -d "$SOURCE_NAME" >/dev/null &
PAREC_PID=$!

# Foreground scrcpy — video is handled by phone-cam.service, so no video here
scrcpy \
	--no-video --no-window --no-playback \
	--audio-source=mic \
	--audio-codec=raw \
	--record-format=wav \
	--record="$PIPE_PATH" \
	--audio-buffer="$LATENCY"
