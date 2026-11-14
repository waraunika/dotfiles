-- looks/widgets/volume.lua
-- pactl for state, `pactl subscribe` for instant updates (keys, scroll, pavucontrol).
-- click: mute, scroll: +-5%, right click: pavucontrol.
local gears = require("gears")
local awful = require("awful")
local c = require("looks.colors")
local util = require("looks.widgets.util")

local g = util.glyph
local icon_low, icon_mid, icon_high, icon_muted = g(0xF057F), g(0xF0580), g(0xF057E), g(0xF0581)

local sink = "@DEFAULT_SINK@"
local MAX_PCT = 150

local listener_pid -- one pactl listener, shared by all screens

return function(s)
	local stat, update = util.stat()
	local tt

	local function refresh()
		awful.spawn.easy_async("pactl get-sink-volume " .. sink, function(out)
			local pct = tonumber(out:match("Volume:.-/%s*(%d+)%%")) or 0
			awful.spawn.easy_async("pactl get-sink-mute " .. sink, function(mout)
				local muted = mout:find("Mute: yes", 1, true) ~= nil
				if muted then
					update(icon_muted, c.outline, tostring(pct))
					tt.text = "Muted (" .. pct .. "%)"
					return
				end
				local icon = pct < 34 and icon_low or (pct < 67 and icon_mid or icon_high)
				update(icon, pct > 100 and c.tertiary or c.on_surface_variant, tostring(pct))
				tt.text = "Volume: " .. pct .. "%"
			end)
		end)
	end

	local function run(cmd)
		return function()
			awful.spawn.easy_async(cmd, refresh)
		end
	end

	local function scroll(delta)
		return function()
			awful.spawn.easy_async("pactl get-sink-volume " .. sink, function(out)
				local cur = tonumber(out:match("Volume:.-/%s*(%d+)%%")) or 0
				local nxt = math.max(0, math.min(MAX_PCT, cur + delta))
				awful.spawn.easy_async("pactl set-sink-volume " .. sink .. " " .. nxt .. "%", refresh)
			end)
		end
	end

	local cell = util.cell(
		stat,
		gears.table.join(
			awful.button({}, 1, run("pactl set-sink-mute " .. sink .. " toggle")),
			awful.button({}, 3, function()
				awful.spawn("pavucontrol")
			end),
			awful.button({}, 4, scroll(5)),
			awful.button({}, 5, scroll(-5))
		)
	)
	tt = util.tooltip(cell)

	-- Debounced refresh from pactl events
	local pending = false
	local function schedule()
		if pending then
			return
		end
		pending = true
		gears.timer.start_new(0.05, function()
			pending = false
			refresh()
			return false
		end)
	end
	awesome.connect_signal("widget::volume_refresh", schedule)

	if not listener_pid then
		listener_pid = awful.spawn.with_line_callback("pactl subscribe", {
			stdout = function(line)
				if line:find("sink", 1, true) or line:find("server", 1, true) then
					awesome.emit_signal("widget::volume_refresh")
				end
			end,
		})
		awesome.connect_signal("exit", function()
			if type(listener_pid) == "number" then
				awesome.kill(listener_pid, awesome.unix_signal.SIGTERM)
			end
		end)
	end

	gears.timer({ timeout = 60, call_now = true, autostart = true, callback = refresh }) -- safety net
	return cell
end
