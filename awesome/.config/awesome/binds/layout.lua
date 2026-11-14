-- binds/layout.lua
-- Direct layout switching plus master-layout controls.
-- Super+Left/Right (resize master/ratio) lives in window.lua,
-- Super+comma (swap with master) too.
local gears = require("gears")
local awful = require("awful")
local vars = require("variables")

local main, pri, sec = vars.mods.mainMod, vars.mods.priMod, vars.mods.secMod
local suit = awful.layout.suit

local function key(mods, k, fn, desc)
	return awful.key(mods, k, fn, { description = desc, group = "layout" })
end

local function set(layout)
	return function()
		awful.layout.set(layout)
	end
end

globalkeys = gears.table.join(
	globalkeys,

	-- Direct switch (same keys as Hypr)
	key({ main, pri }, "d", set(suit.spiral.dwindle), "dwindle"),
	key({ main, pri }, "m", set(suit.tile), "master (left)"),
	key({ main, pri }, "s", set(suit.max), "stack (max)"),

	-- Master orientation (Hypr: orientationleft / orientationright)
	key({ main }, "bracketleft", set(suit.tile), "master on the left"),
	key({ main }, "bracketright", set(suit.tile.left), "master on the right"),

	-- Master count (Hypr: addmaster / removemaster)
	key({ main, pri }, "period", function()
		awful.tag.incnmaster(1, nil, true)
	end, "add master"),
	key({ main, sec }, "period", function()
		awful.tag.incnmaster(-1, nil, true)
	end, "remove master")
)
