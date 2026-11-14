-- widgets: tray.lua

local wibox = require("wibox")
local vars = require("variables")
local awful = require("awful")

return function(s)
	if not vars.bar.systray then
		return nil
	end
	local tray = wibox.widget.systray()
	tray.horizontal = false
	tray.base_size = 20
	return wibox.widget({ tray, halign = "center", widget = wibox.container.place })
end
