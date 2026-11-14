-- widgets: rest.lua
-- from the script: rest

local gears = require("gears")
local awful = require("awful")
local vars = require("variables")
local c = require("looks.colors")
local util = require("looks.widgets.util")

local g = util.glyph
local bell, bell_off = g(0xEA70), g(0xF0209)

return function(s)
	local stat, update = util.stat()
	local tt

	local function refresh()
		awful.spawn.easy_async_with_shell("~/scripts/rest status", function(out)
			if not out:find("is RUNNING", 1, true) then
				update(bell_off, c.outline)
				tt.text = (out:gsub("^%s+", ""):gsub("%s+$", ""))
				if tt.text == "" then
					tt.text = "Rest reminder is stopped"
				end
				return
			end

			local nxt = out:match("Next notification in:%s*([^\n]+)") or ""
			local short = nxt:match("(%d+)m") and (nxt:match("(%d+)m") .. "M")
				or (nxt:match("(%d+)s") and (nxt:match("(%d+)s") .. "S"))
				or ""
			update(bell, c.primary, short)
			tt.text = (out:gsub("^%s+", ""):gsub("%s+$", ""))
		end)
	end

	local cell = util.cell(
		stat,
		gears.table.join(
			awful.button({}, 1, function()
				awful.spawn.with_shell("~/scripts/rest toggle")
				gears.timer.start_new(0.6, function()
					refresh()
					return false
				end)
			end),
			awful.button({}, 3, refresh)
		)
	)

	tt = util.tooltip(cell)

	gears.timer({ timeout = vars.bar.rest_interval, call_now = true, autostart = true, callback = refresh })

	return cell
end
