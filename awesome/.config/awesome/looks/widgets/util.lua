-- widget: util.lua
-- helpers for bar widgets

local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local vars = require("variables")

local cfg = vars.bar
local M = {}

function M.glyph(cp)
	if cp < 0x10000 then
		return string.char(0xE0 + math.floor(cp / 0x1000), 0x80 + math.floor(cp / 0x40) % 0x40, 0x80 + cp % 0x40)
	end

	return string.char(
		0xF0 + math.floor(cp / 0x40000),
		0x80 + math.floor(cp / 0x1000) % 0x40,
		0x80 + math.floor(cp / 0x40) % 0x40,
		0x80 + cp % 0x40
	)
end

--- "#rrggbb" + 0..1 -> "#rrggbbaa"
function M.alpha(hex, a)
	return hex .. string.format("%02x", math.floor(a * 255 + 0.5))
end

function M.rounded(r)
	return function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, r)
	end
end

M.icon_font = cfg.font .. " " .. cfg.icon_size
M.value_font = cfg.font .. " Bold " .. math.max(cfg.font_size - 3, 6)

--- Icon with a tiny value below
function M.stat()
	local icon = wibox.widget.textbox()
	icon.align = "center"
	local value = wibox.widget.textbox()
	value.align = "center"
	value.visible = false

	local w = wibox.widget({ icon, value, layout = wibox.layout.fixed.vertical })

	local function update(glyph, color, text)
		icon:set_markup(string.format('<span font="%s" foreground="%s">%s</span>', M.icon_font, color, glyph))

		if cfg.show_values and text and text ~= "" then
			value:set_markup(string.format('<span font="%s" foreground="%s">%s</span>', M.value_font, color, text))
			value.visible = true
		else
			value.visible = false
		end
	end

	return w, update
end

--- centering widgets horizontally
function M.cell(child, buttons)
	local w = wibox.widget({
		{ child, top = 2, bottom = 2, widget = wibox.container.margin },
		halign = "center",
		widget = wibox.container.place,
	})

	if buttons then
		w:buttons(buttons)
	end

	return w
end

--- tooltip that opens inside the bar
function M.tooltip(obj, fn)
	return awful.tooltip({
		objects = { obj },
		timer_function = fn,
		mode = "outside",
		preferred_positions = { "right", "left" },
		preferred_alignments = { "middle" },
	})
end

return M
