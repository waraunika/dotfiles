-- binds/scripts.lua
-- Super+Alt+key runs a script from ~/scripts. Ctrl/Shift pick the variant.
local gears = require("gears")
local awful = require("awful")
local vars = require("variables")

local main, pri, sec, alt = vars.mods.mainMod, vars.mods.priMod, vars.mods.secMod, vars.mods.scriptMod

-- format: { key, cmd, extra mods (optional) }
local keymaps = {
	{ "r", "~/scripts/record" },
	{ "a", "~/scripts/record audio" },
	{ "b", "~/scripts/rest toggle" },
	{ "b", "~/scripts/rest start", { pri } },
	{ "b", "~/scripts/rest stop", { sec } },
	{ "b", "~/scripts/rest status", { pri, sec } },
	{ "m", "~/scripts/rofi-music" },
	{ "t", "~/scripts/wallpaper" },
}

for _, map in ipairs(keymaps) do
	local k, cmd, extra = map[1], map[2], map[3]
	local mods = { main, alt }
	for _, m in ipairs(extra or {}) do
		table.insert(mods, m)
	end
	globalkeys = gears.table.join(
		globalkeys,
		awful.key(mods, k, function()
			awful.spawn.with_shell(cmd)
		end, { description = cmd, group = "scripts" })
	)
end

-- Emoji picker
globalkeys = gears.table.join(
	globalkeys,
	awful.key({ main }, "period", function()
		awful.spawn.with_shell("~/scripts/rofi-emoji")
	end, { description = "emoji picker", group = "scripts" })
)
