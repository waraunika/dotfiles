-- binds/window.lua
-- Window navigation: focus, swap, close/float/fullscreen, tags (workspaces).
-- Replaces the default-port client.lua and tags.lua. Delete those two files
-- and their require lines in rc.lua.
local gears = require("gears")
local awful = require("awful")
local vars = require("variables")

local main, pri, sec = vars.mods.mainMod, vars.mods.priMod, vars.mods.secMod

local function key(mods, k, fn, desc, group)
	return awful.key(mods, k, fn, { description = desc, group = group })
end

local function focus_dir(dir)
	return function()
		awful.client.focus.bydirection(dir)
		if client.focus then
			client.focus:raise()
		end
	end
end

local function focus_idx(n)
	return function()
		awful.client.focus.byidx(n)
		if client.focus then
			client.focus:raise()
		end
	end
end

globalkeys = gears.table.join(
	globalkeys,

	-- Focus by direction (vim keys + arrows)
	key({ main }, "h", focus_dir("left"), "focus left", "client"),
	key({ main }, "j", focus_dir("down"), "focus down", "client"),
	key({ main }, "k", focus_dir("up"), "focus up", "client"),
	key({ main }, "l", focus_dir("right"), "focus right", "client"),
	key({ main }, "Up", focus_dir("up"), "focus up", "client"),
	key({ main }, "Down", focus_dir("down"), "focus down", "client"),

	-- Cycle (the stack/max layout workflow)
	key({ main }, "Tab", focus_idx(1), "focus next", "client"),
	key({ main, sec }, "Tab", focus_idx(-1), "focus previous", "client"),

	-- Swap with neighbour (Ctrl = "move")
	key({ main, pri }, "h", function()
		awful.client.swap.bydirection("left")
	end, "swap left", "client"),
	key({ main, pri }, "j", function()
		awful.client.swap.bydirection("down")
	end, "swap down", "client"),
	key({ main, pri }, "k", function()
		awful.client.swap.bydirection("up")
	end, "swap up", "client"),
	key({ main, pri }, "l", function()
		awful.client.swap.bydirection("right")
	end, "swap right", "client"),

	-- Master helpers (same keys as the Hypr master layout)
	key({ main, pri }, "comma", function()
		local m = awful.client.getmaster()
		if m then
			client.focus = m
			m:raise()
		end
	end, "focus master", "client"),

	-- Resize master width (Hypr: colresize on left/right)
	key({ main }, "Left", function()
		awful.tag.incmwfact(-0.05)
	end, "shrink master", "layout"),
	key({ main }, "Right", function()
		awful.tag.incmwfact(0.05)
	end, "grow master", "layout"),

	-- Screens
	key({ main, pri }, "o", function()
		awful.screen.focus_relative(1)
	end, "focus other screen", "screen"),

	-- Minimized / urgent
	key({ main, pri }, "z", function()
		local c = awful.client.restore()
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, "restore minimized", "client"),
	key({ main }, "u", awful.client.urgent.jumpto, "jump to urgent", "client"),

	-- Tags
	key({ main }, "Escape", awful.tag.history.restore, "previous tag", "tag")
)

-- Tags 1..10: Super+N view, Super+Ctrl+N move window, Super+Shift+N toggle view.
-- Keycodes (#10..#19) are layout-independent; #19 is the 0 key = tag 10.
for i = 1, 10 do
	local code = "#" .. (i + 9)
	globalkeys = gears.table.join(
		globalkeys,
		key({ main }, code, function()
			local tag = awful.screen.focused().tags[i]
			if tag then
				tag:view_only()
			end
		end, "view tag #" .. i, "tag"),
		key({ main, pri }, code, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, "move window to tag #" .. i, "tag"),
		key({ main, sec }, code, function()
			local tag = awful.screen.focused().tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, "toggle tag #" .. i, "tag")
	)
end

clientkeys = gears.table.join(
	clientkeys,
	key({ main }, "q", function(c)
		c:kill()
	end, "close", "client"),
	key({ main }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, "toggle fullscreen", "client"),
	key({ main, pri }, "f", awful.client.floating.toggle, "toggle floating", "client"),
	key({ main, pri }, "t", function(c)
		c.ontop = not c.ontop
	end, "toggle on top", "client"),
	key({ main }, "comma", function(c)
		c:swap(awful.client.getmaster())
	end, "swap with master", "client"),
	key({ main }, "o", function(c)
		c:move_to_screen()
	end, "move to other screen", "client"),
	key({ main }, "z", function(c)
		c.minimized = true
	end, "minimize", "client")
)

clientbuttons = gears.table.join(
	clientbuttons,
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ main }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ main }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)
