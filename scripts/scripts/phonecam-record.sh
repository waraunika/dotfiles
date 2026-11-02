#!/bin/bash
# Record phone camera + mic with ffmpeg, with a live preview window.
# Usage: ./phonecam-record.sh [output.mkv]

OUT="${1:-capture_$(date +%Y%m%d_%H%M%S).mkv}"
VDEV=/dev/video10
SINK=phone_mic
SRC=phone_mic_src

cleanup() {
	kill $PREVIEW_PID $SCRCPY_PID 2>/dev/null
	wait 2>/dev/null
}
trap cleanup EXIT

# 1. Make sure the virtual mic exists (sink for scrcpy, source for ffmpeg)
if ! timeout 3 pactl list sinks short | grep -q "$SINK"; then
	pw-loopback -m '[FL FR]' \
		--capture-props="media.class=Audio/Sink node.name=$SINK node.description=PhoneMic" \
		--playback-props="media.class=Audio/Source node.name=$SRC node.description=PhoneMicInput" &
	sleep 1
fi

# 2. Start scrcpy (video -> v4l2 loopback, audio -> default sink for now)
scrcpy --video-source=camera --camera-id=0 --camera-size=1920x1080 --camera-fps=30 \
	--audio-source=mic --no-video-playback --no-window \
	--v4l2-sink=$VDEV &
SCRCPY_PID=$!
sleep 3

# 3. Move scrcpy's audio stream into the virtual mic sink
for i in {1..20}; do
	id=$(timeout 3 pactl list sink-inputs | awk '/^Sink Input #/{id=substr($3,2)} /application.process.binary = "scrcpy"/{print id}' | tail -1)
	if [ -n "$id" ]; then
		pactl move-sink-input "$id" "$SINK" && echo "Moved stream $id to $SINK"
		break
	fi
	sleep 0.5
done

# 4. Live preview window (low latency)
ffplay -f v4l2 -framerate 30 -video_size 1920x1080 \
	-fflags nobuffer -flags low_delay -window_title "Preview" $VDEV &
PREVIEW_PID=$!
sleep 1

# 5. Record video + audio. Press q in this terminal to stop cleanly.
ffmpeg -thread_queue_size 512 -use_wallclock_as_timestamps 1 \
	-f v4l2 -framerate 30 -video_size 1920x1080 -i $VDEV \
	-thread_queue_size 512 -f pulse -i $SRC \
	-c:v libx264 -preset veryfast -crf 20 -pix_fmt yuv420p \
	-c:a aac -b:a 128k \
	-af aresample=async=1 \
	"$OUT"

echo "Saved to $OUT"
