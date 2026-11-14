local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local util = require("looks.widgets.util")

return function(s)
	local lb = awful.widget.layoutbox(s)
	local sized = wibox.widget({
		lb,
		width = 20,
		height = 20,
		strategy = "exact",
		widget = wibox.container.constraint,
	})
	util.tooltip(sized, function()
		return awful.layout.getname(awful.layout.get(s)) or ""
	end)
	return util.cell(
		sized,
		gears.table.join(
			awful.button({}, 1, function()
				awful.layout.inc(1)
			end),
			awful.button({}, 3, function()
				awful.layout.inc(-1)
			end),
			awful.button({}, 4, function()
				awful.layout.inc(1)
			end),
			awful.button({}, 5, function()
				awful.layout.inc(-1)
			end)
		)
	)
end
