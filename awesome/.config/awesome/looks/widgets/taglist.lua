local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local vars = require("variables")

local main = vars.mods.mainMod
local cfg = vars.bar

local buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),

	awful.button({ main }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),

	awful.button({}, 3, awful.tag.viewtoggle),

	awful.button({ main }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),

	awful.button({}, 4, function(t)
		awful.tag.viewprev(t.screen)
	end),

	awful.button({}, 5, function(t)
		awful.tag.viewnext(t.screen)
	end)
)

return function(s)
	return awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.noempty,
		buttons = buttons,
		layout = { spacing = 4, layout = wibox.layout.fixed.vertical },
		widget_template = {
			{
				id = "text_role",
				align = "center",
				valign = "center",
				widget = wibox.widget.textbox,
			},
			id = "background_role",
			forced_width = cfg.cell,
			forced_height = cfg.cell,
			widget = wibox.container.background,
		},
		halign = "center",
		widget = wibox.container.place,
	})
end
