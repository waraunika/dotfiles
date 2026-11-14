local awful = require("awful")
local gears = require("gears")

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

-- Don't lock or blank the screen while a fullscreen window is visible
-- (video, games). ~/scripts/idle sets/clears the flag. Any fullscreen window
-- counts, not only video, so a fullscreen terminal also keeps the screen on.
local idle_cmd = os.getenv("HOME") .. "/scripts/idle"
local fullscreen_seen = nil -- nil on startup so the first check always reports

local function check_fullscreen()
	local any = false
	for _, c in ipairs(client.get()) do
		if c.fullscreen and not c.minimized and c:isvisible() then
			any = true
			break
		end
	end
	if any ~= fullscreen_seen then
		fullscreen_seen = any
		awful.spawn({ idle_cmd, "auto", any and "on" or "off" })
	end
end

-- Deferred so a closing client is already gone when we look.
local function schedule_check()
	gears.timer.delayed_call(check_fullscreen)
end

client.connect_signal("property::fullscreen", schedule_check)
client.connect_signal("property::minimized", schedule_check)
client.connect_signal("unmanage", schedule_check)
client.connect_signal("tagged", schedule_check)
client.connect_signal("untagged", schedule_check)
tag.connect_signal("property::selected", schedule_check)
schedule_check()
