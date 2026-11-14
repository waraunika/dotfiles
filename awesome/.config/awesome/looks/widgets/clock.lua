-- looks/widgets/clock.lua
-- Stacked HH over MM. Tooltip shows the date.
local wibox = require("wibox")
local vars = require("variables")
local c = require("looks.colors")
local util = require("looks.widgets.util")

local cfg = vars.bar.clock

return function(s)
	local fmt = string.format(
		'<span foreground="%s">%s</span>\n<span foreground="%s">%s</span>',
		c.on_surface,
		cfg.hour,
		c.primary,
		cfg.minute
	)
	local clock = wibox.widget.textclock(fmt, 10)
	util.tooltip(clock, function()
		return os.date(cfg.tooltip)
	end)
	return util.cell(clock)
end
