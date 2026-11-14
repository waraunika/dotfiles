-- binds/mouse.lua
-- Desktop right-click menu, Super+scroll for tags, and the thumb buttons.
-- Super+LMB move / Super+RMB resize live in window.lua (clientbuttons).
local gears = require("gears")
local awful = require("awful")
local vars = require("variables")

local main = vars.mods.mainMod

-- ASUS TUF M5 thumb buttons: 8 = back thumb, 9 = front thumb.
-- With no modifier, Awesome grabs these before apps see them, so browser
-- back/forward on the thumb buttons stops working. Set this to { main } to
-- keep that (the thumb buttons then need Super held).
local thumb_mods = {}

local function run(cmd)
	return function()
		awful.spawn.with_shell(cmd)
	end
end

-- Front thumb: copy the current selection (X11 primary) into the clipboard.
-- Works in every app, including terminals where Ctrl+C means interrupt.
local copy_selection = run("xclip -o -selection primary | xclip -selection clipboard && xdotool click 1")
-- Back thumb: clipboard history in rofi (clipmenu, daemon started in autostart.sh).
local clipboard_history = run("CM_LAUNCHER=rofi clipmenu")

-- Same buttons on the desktop (root) and on windows (clients).
-- Scroll direction matches Hypr: up = previous tag, down = next tag.
local function shared_buttons()
	return gears.table.join(
		awful.button({ main }, 4, function()
			awful.tag.viewprev(awful.screen.focused())
		end),
		awful.button({ main }, 5, function()
			awful.tag.viewnext(awful.screen.focused())
		end),
		awful.button(thumb_mods, 11, copy_selection),
		awful.button(thumb_mods, 10, clipboard_history)
	)
end

root.buttons(gears.table.join(
	awful.button({}, 3, function()
		mymainmenu:toggle()
	end),
	shared_buttons()
))

clientbuttons = gears.table.join(clientbuttons, shared_buttons())
