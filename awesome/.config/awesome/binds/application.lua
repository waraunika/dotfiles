-- binds/application.lua
-- Super + letter launches an app. Ctrl adds the alternate variant.
local gears = require("gears")
local awful = require("awful")
local vars = require("variables")

local main, pri, sec = vars.mods.mainMod, vars.mods.priMod, vars.mods.secMod
local apps = vars.apps

-- Run through a shell so "~" and env vars work in commands.
local function run(cmd)
	return function()
		awful.spawn.with_shell(cmd)
	end
end

-- Like the Hypr config: some keys also jump to a tag, so you land on
-- steam/discord/mail even when the app is already running.
local function run_and_view(cmd, tag_index)
	return function()
		awful.spawn.with_shell(cmd)
		local tag = awful.screen.focused().tags[tag_index]
		if tag then
			tag:view_only()
		end
	end
end

local function key(mods, k, fn, desc)
	return awful.key(mods, k, fn, { description = desc, group = "launcher" })
end

globalkeys = gears.table.join(
	globalkeys,

	key({ main }, "Return", function()
		awful.spawn(apps.terminal)
	end, "terminal"),
	key({ main, pri }, "Return", function()
		awful.spawn(apps.terminal, { floating = true })
	end, "floating terminal"),

	key({ main }, "b", run(apps.browser), "browser"),
	key({ main }, "d", run("emacs"), "emacs"),
	key({ main }, "c", run_and_view(apps.calendar, 4), "calendar (tag 4)"),
	key({ main }, "e", run(apps.fileManager), "file manager"),
	key({ main, pri }, "e", run(apps.fileManager1), "file manager (gui)"),
	key({ main }, "n", run(apps.editor), "editor"),
	key({ main }, "s", run_and_view("prime-run steam", 9), "steam (tag 9)"),
	key({ main }, "v", run_and_view("vesktop", 10), "vesktop (tag 10)"),
	key({ main }, "w", run_and_view("whatsie", 10), "whatsie (tag 10)"),
	key({ main }, "x", run("sioyek --new-instance"), "sioyek"),
	key({ main }, "y", run(apps.browser .. " youtube.com"), "youtube"),

	-- Exit awesome (Hypr: Super+Ctrl+Shift+M)
	key({ main, pri, sec }, "m", function()
		awesome.quit()
	end, "quit awesome")
)
