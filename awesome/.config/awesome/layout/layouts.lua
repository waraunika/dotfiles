local awful = require("awful")

awful.layout.layouts = {
	awful.layout.suit.spiral.dwindle, -- dwindle
	awful.layout.suit.tile, -- master on the left
	awful.layout.suit.tile.left, -- master on the right
	awful.layout.suit.max, -- stack: one window at a time, cycle with Super+Tab
}
