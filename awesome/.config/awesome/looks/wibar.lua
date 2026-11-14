-- looks: wibar
-- trying out for vertical bar, lets see what this turns out to be.
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local vars = require("variables")
local c = require("looks.colors")
local util = require("looks.widgets.util")

local cfg = vars.bar

--- load one widget; skip broken widget
local function load(name, s)
	local ok, mod = pcall(require, "looks.widgets." .. name)
	if not ok then
		gears.debug.print_error("wibar: cannot load '" .. name .. "': " .. tostring(mod))
		return nil
	end

	local ok2, w = pcall(mod, s)

	if not ok2 then
		gears.debug.print_error("wibar: widget '" .. name .. "' failed: " .. tostring(w))
	end

	return w
end

local function stack(names, s, spacing)
	local l = wibox.layout.fixed.vertical()
	l.spacing = spacing
	for _, name in ipairs(names) do
		local w = load(name, s)
		if w then
			l:add(w)
		end
	end

	return l
end

local function build(items, s)
	local l = wibox.layout.fixed.vertical()
	l.spacing = cfg.spacing
	for _, item in ipairs(items) do
		if type(item) == "table" then
			l:add(wibox.widget({
				{ stack(item, s, cfg.spacing), margins = cfg.pill_padding, widget = wibox.container.margin },
				bg = c.surface_container,
				shape = util.rounded(cfg.pill_radius),
				widget = wibox.container.background,
			}))
		else
			local w = load(item, s)
			if w then
				l:add(w)
			end
		end
	end

	return l
end

awful.screen.connect_for_each_screen(function(s)
	local m = cfg.floating and cfg.margin or 0

	s.mywibox = awful.wibar({
		position = "left",
		screen = s,
		width = cfg.width + m * 2,
		bg = cfg.floating and "#00000000" or c.background,
		fg = c.on_surface,
	})

	local align = wibox.layout.align.vertical()
	align:set_first(build(cfg.top, s))
	align:set_second(wibox.widget({ build(cfg.middle, s), valign = "center", widget = wibox.container.place }))
	align:set_third(build(cfg.bottom, s))

	s.mywibox:setup({
		{
			{ align, margins = cfg.padding, widget = wibox.container.margin },
			bg = cfg.floating and util.alpha(c.surface, cfg.opacity) or c.background,
			shape = cfg.floating and util.rounded(cfg.radius) or nil,
			shape_border_width = cfg.floating and 1 or 0,
			shape_border_color = c.outline_variant,
			widget = wibox.container.background,
		},
		margins = m,
		widget = wibox.container.margin,
	})
end)
