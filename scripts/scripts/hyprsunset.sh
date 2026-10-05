#!/usr/bin/env bash
TEMP="${HYPRSUNSET_TEMP:-4500}"

case "${1:-}" in
  toggle)
    if pgrep -x hyprsunset >/dev/null; then
      pkill -x hyprsunset
      notify-send -u low "Night light off"
    else
      nohup hyprsunset -t "$TEMP" >/dev/null 2>&1 &
      notify-send -u low "Night light on" "${TEMP}K"
    fi
    ;;
  status)
    if pgrep -x hyprsunset >/dev/null; then
      echo '{"text":"󰽥","class":"on","tooltip":"Night light on"}'
    else
      echo '{"text":"☀","class":"off","tooltip":"Night light off"}'
    fi
    ;;
  *)
    echo "usage: $0 [toggle|status]" >&2
    exit 2
    ;;
esac
