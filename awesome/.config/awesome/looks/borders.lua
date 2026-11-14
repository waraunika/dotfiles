local beautiful = require("beautiful")
local pal = require("looks.colors")

-- State-based color: urgent > floating > normal focus
local function paint(c)
	if c.urgent then
		c.border_color = pal.error
	elseif c == client.focus then
		c.border_color = c.floating and pal.tertiary or beautiful.border_focus
	else
		c.border_color = beautiful.border_normal
	end
end

client.connect_signal("focus", paint)
client.connect_signal("unfocus", paint)
client.connect_signal("property::urgent", paint)
client.connect_signal("property::floating", paint)

-- Smart borders: none in the stack (max) layout, with one tiled window, or when maximized
screen.connect_signal("arrange", function(s)
	local tag = s.selected_tag
	local max = tag and tag.layout.name == "max"
	local single = #s.tiled_clients == 1
	for _, c in ipairs(s.clients) do
		if ((max or single) and not c.floating) or c.maximized or c.fullscreen then
			c.border_width = 0
		else
			c.border_width = beautiful.border_width
		end
	end
end)
