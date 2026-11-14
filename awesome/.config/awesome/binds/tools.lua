-- binds/tools.lua
-- Launcher, screenshots, color picker, lock, power menu, media keys.
local gears = require("gears")
local awful = require("awful")
local vars = require("variables")

local main, pri, sec = vars.mods.mainMod, vars.mods.priMod, vars.mods.secMod

local function run(cmd)
	return function()
		awful.spawn.with_shell(cmd)
	end
end

local function key(mods, k, cmd, desc, group)
	return awful.key(mods, k, run(cmd), { description = desc, group = group or "tools" })
end

local shots = "$HOME/Pictures/Screenshots"

globalkeys = gears.table.join(
	globalkeys,

	-- Launchers
	key({ main }, "space", vars.apps.menu2, "rofi launcher"),
	key({ main, pri }, "space", vars.apps.menu, "rofi drun"),

	-- Screenshots. "#10" is the 1 key: with Shift held, the keysym "1" would
	-- turn into "exclam", the keycode does not.
	key(
		{ pri, sec },
		"#10",
		"mkdir -p " .. shots .. ' && maim -s "' .. shots .. '/$(date +%Y%m%d_%H%M%S).png"',
		"screenshot region to file"
	),
	key({ main, sec }, "s", "maim -s | xclip -selection clipboard -t image/png", "screenshot region to clipboard"),

	-- Color picker, copies to clipboard
	key({ main, sec }, "h", "xcolor -s", "color picker"),

	-- Lock (xss-lock runs i3lock) and power menu
	key({ main, sec }, "l", "xset s activate", "lock screen"),
	key({ main, sec }, "p", "~/scripts/rofi-power", "power menu"),
	key({ main, sec }, "i", "~/scripts/idle toggle", "toggle idle lock (stay awake)"),

	-- Volume
	key(
		{},
		"XF86AudioRaiseVolume",
		"[ $(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]*%' | head -1 | tr -d %) -lt 150 ] && pactl set-sink-volume @DEFAULT_SINK@ +5%",
		"volume up",
		"media"
	),
	key({}, "XF86AudioLowerVolume", "pactl set-sink-volume @DEFAULT_SINK@ -5%", "volume down", "media"),
	key({}, "XF86AudioMute", "pactl set-sink-mute @DEFAULT_SINK@ toggle", "mute", "media"),
	key({}, "XF86AudioMicMute", "pactl set-source-mute @DEFAULT_SOURCE@ toggle", "mic mute", "media"),

	-- Brightness
	key({}, "XF86MonBrightnessUp", "brightnessctl set 3%+", "brightness up", "media"),
	key({}, "XF86MonBrightnessDown", "brightnessctl set 3%-", "brightness down", "media"),

	-- Player
	key({}, "XF86AudioNext", "playerctl next", "next track", "media"),
	key({}, "XF86AudioPause", "playerctl play-pause", "play/pause", "media"),
	key({}, "XF86AudioPlay", "playerctl play-pause", "play/pause", "media"),
	key({}, "XF86AudioPrev", "playerctl previous", "previous track", "media"),

	-- Notifications via dunst
	key({ main }, "grave", "dunstctl history-pop", "notification history (pop last)", "notifications"),
	key({ main, sec }, "grave", "dunstctl close-all", "dismiss all notifications", "notifications"),
	key({ main, pri }, "grave", "dunstctl set-paused toggle", "toggle do-not-disturb", "notifications"),
	key({ main, sec }, "n", "~/scripts/rofi-notifs", "notification list", "notifications")
)
