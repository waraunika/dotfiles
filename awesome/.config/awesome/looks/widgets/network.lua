-- widget: network.lua
-- nmcli's NetworkManager

local gears = require("gears")
local awful = require("awful")
local vars = require("variables")
local c = require("looks.colors")
local util = require("looks.widgets.util")

local g = util.glyph
local wifi = { g(0xF092F), g(0xF091F), g(0xF0922), g(0xF0925), g(0xF0928) }
local ethernet, offline = g(0xF0318), g(0xF0319)

local cmd = [[
line=$(nmcli -t -f TYPE,STATE,CONNECTION device 2>/dev/null | grep -m1 -E '^(wifi|ethernet):connected')
sig=$(nmcli -t -f IN-USE,SIGNAL device wifi list --rescan no 2>/dev/null | grep -m1 '^\*' | cut -d: -f2)
echo "$line|$sig"
]]

return function(s)
	local stat, update = util.stat()
	local cell = util.cell(
		stat,
		gears.table.join(awful.button({}, 1, function()
			awful.spawn(vars.apps.terminal .. " -e nmtui", { floating = true })
		end))
	)
	local tt = util.tooltip(cell)

	local function refresh()
		awful.spawn.easy_async_with_shell(cmd, function(out)
			local kind, name, sig = out:match("^(%a+):connected:(.-)|(%d*)%s*$")
			if not kind then
				update(offline, c.outline)
				tt.text = "Disconnected"
				return
			end

			name = name:gsub("\\:", ":")
			if kind == "wifi" then
				local pct = tonumber(sig) or 0
				update(wifi[math.max(1, math.min(5, math.ceil(pct / 20)))], c.on_surface_variant)
				tt.text = name .. " (" .. pct .. "%)"
			else
				update(ethernet, c.on_surface_variant)
				tt.text = "Wired: " .. name
			end
		end)
	end

	gears.timer({ timeout = vars.bar.network_interval, call_now = true, autostart = true, callback = refresh })

	return cell
end
