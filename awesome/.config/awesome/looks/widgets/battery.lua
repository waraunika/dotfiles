-- widget: battery

local gears = require("gears")
local vars = require("variables")
local c = require("looks.colors")
local util = require("looks.widgets.util")

local g = util.glyph
local levels = {
	g(0xF008E),
	g(0xF007A),
	g(0xF007B),
	g(0xF007C),
	g(0xF007D),
	g(0xF007E),
	g(0xF007F),
	g(0xF0080),
	g(0xF0081),
	g(0xF0082),
	g(0xF0079),
}

local charging_icon = g(0xF0084)
local plugged_icon = g(0xF06A5)

return function(s)
	local base = "/sys/class/power_supply/" .. vars.bar.battery .. "/"
	local function read(name)
		local f = io.open(base .. name)
		if not f then
			return nil
		end

		local v = f:read("*l")
		f:close()
		return v
	end

	local function ac_online()
		for _, n in ipairs({ "ACAD", "AC", "AC0", "ADP0", "ADP1" }) do
			local f = io.open("/sys/class/power_supply/" .. n .. "/online")
			if f then
				local v = f:read("*l")
				f:close()
				return v == "1"
			end
		end
		return nil -- adapter not found
	end

	local stat, update = util.stat()
	local cell = util.cell(stat)
	local tt = util.tooltip(cell)

	local function refresh()
		local cap = tonumber(read("capacity"))
		if not cap then
			cell.visible = false
			return
		end

		local status = read("status") or "Unknown"
		local plugged = status == "Full" or status == "Not charging" or (status == "Unknown" and ac_online() == true)
		if plugged and status == "Unknown" then
			status = "Plugged in"
		end

		local icon, color = levels[math.floor(cap / 10) + 1], c.on_surface_variant
		if status == "Charging" then
			icon, color = charging_icon, c.primary
		elseif plugged then
			icon, color = plugged_icon, c.primary
		elseif cap <= 15 then
			color = c.error
		end

		update(icon, color, tostring(cap))
		tt.text = cap .. "% (" .. status .. ")"
	end

	gears.timer({ timeout = 30, call_now = true, autostart = true, callback = refresh })
	return cell
end
