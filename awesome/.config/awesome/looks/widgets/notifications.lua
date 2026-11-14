-- widgets: notifications
-- dunstctl for state

local gears = require("gears")
local awful = require("awful")
local vars = require("variables")
local c = require("looks.colors")
local util = require("looks.widgets.util")

local g = util.glyph
local bell, bell_paused = g(0xF009C), g(0xF0A91)

local cmd = "dunstctl is-paused; dunstctl count displayed; dunstctl count waiting; dunstctl count history"

return function(s)
	local stat, update = util.stat()
	local tt

	local function refresh()
		awful.spawn.easy_async_with_shell(cmd, function(out)
			local lines = {}
			for l in out:gmatch("[^\n]+") do
				lines[#lines + 1] = l
			end
			local paused = lines[1] == "true"
			local shown = tonumber(lines[2]) or 0
			local waiting = tonumber(lines[3]) or 0
			local history = tonumber(lines[4]) or 0

			if paused then
				update(bell_paused, c.tertiary, waiting > 0 and tostring(waiting) or nil)
				tt.text = "Do not disturb\nQueued: " .. waiting .. "\nHistory: " .. history
			else
				update(bell, shown > 0 and c.primary or c.on_surface_variant)
				tt.text = "Showing: " .. shown .. "\nHistory: " .. history
			end
		end)
	end

	local function act(command)
		return function()
			awful.spawn.easy_async("dunstctl " .. command, refresh)
		end
	end

	local cell = util.cell(

		stat,

		gears.table.join(

			awful.button({}, 1, act("history-pop")),
			awful.button({}, 2, act("history-clear")),
			awful.button({}, 3, act("set-paused toggle")),
			awful.button({}, 4, act("close-all")),
			awful.button({}, 5, act("close-all"))
		)
	)
	tt = util.tooltip(cell)
	gears.timer({
		timeout = vars.bar.notif_interval,
		call_now = true,
		autostart = true,
		callback = refresh,
	})

	return cell
end
