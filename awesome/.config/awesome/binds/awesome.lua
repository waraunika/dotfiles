-- binds/awesome.lua
-- Awesome-specific binds only. Launching apps lives in application.lua,
-- quitting is Super+Ctrl+Shift+M there. Rofi (Super+Space) goes in tools.lua.
local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local beautiful = require("beautiful")
local wibox = require("wibox")
local vars = require("variables")

local main, pri = vars.mods.mainMod, vars.mods.priMod

local function lua_prompt()
	local s = awful.screen.focused()
	local pb = awful.widget.prompt()
	local box = wibox({
		screen = s,
		ontop = true,
		visible = true,
		width = 480,
		height = 40,
		bg = beautiful.bg_focus,
		fg = beautiful.fg_normal,
		shape = function(cr, w, h)
			gears.shape.rounded_rect(cr, w, h, 10)
		end,
	})

	box:setup({ pb, left = 14, right = 14, widget = wibox.container.margin })
	awful.placement.top(box, { parent = s, margin = { top = 24 } })
	awful.prompt.run({
		prompt = "Lua: ",
		textbox = pb.widget,
		exe_callback = awful.util.eval,
		history_path = awful.util.get_cache_dir() .. "/history_eval",
		done_callback = function()
			box.visible = false
		end,
	})
end

globalkeys = gears.table.join(
	globalkeys,

	awful.key({ main }, "F1", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	awful.key({ main, pri }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ main, pri }, "x", lua_prompt, { description = "lua execute prompt", group = "awesome" })
)
