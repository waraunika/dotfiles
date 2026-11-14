local gears = require("gears")
local beautiful = require("beautiful")
local c = require("looks.colors")
local vars = require("variables")

local cfg = vars.bar
local themes_path = gears.filesystem.get_themes_dir()
local theme = dofile(themes_path .. "default/theme.lua")

local function rounded(r)
	return function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, r)
	end
end

-- Base
theme.font = cfg.font .. " Bold " .. cfg.font_size
theme.wallpaper = nil
theme.useless_gap = cfg.gap

theme.bg_normal = c.background
theme.bg_focus = c.surface_container_high
theme.bg_urgent = c.error
theme.bg_minimize = c.surface_container
theme.bg_systray = c.surface_container

theme.fg_normal = c.on_surface
theme.fg_focus = c.primary
theme.fg_urgent = c.n_error
theme.fg_minimize = c.outline

-- Window borders
theme.border_width = 2
theme.border_normal = c.surface_container_high
theme.border_focus = c.primary
theme.border_marked = c.tertiary

-- Titlebars
theme.titlebar_bg_normal = c.surface_container
theme.titlebar_bg_focus = c.surface_container_high
theme.titlebar_fg_normal = c.outline
theme.titlebar_fg_focus = c.on_surface

-- Taglist
theme.taglist_squares_sel = nil
theme.taglist_squares_unsel = nil
theme.taglist_shape = rounded(math.floor(cfg.cell / 3))
theme.taglist_bg_focus = c.primary
theme.taglist_fg_focus = c.on_primary
theme.taglist_bg_occupied = c.surface_container_high
theme.taglist_fg_occupied = c.on_surface
theme.taglist_bg_urgent = c.error
theme.taglist_fg_urgent = c.on_error

-- Tooltips and notifs
theme.tooltip_bg = c.surface_container_high
theme.tooltip_fg = c.on_surface
theme.tooltip_border_color = c.outline_variant
theme.tooltip_border_width = 1
theme.notification_bg = c.surface_container_high
theme.notification_fg = c.on_surface
theme.notification_border_color = c.primary
theme.notification_border_width = 1
theme.notification_shape = rounded(10)

-- Task theme
theme.tasklist_bg_normal = "#00000000"
theme.tasklist_bg_minimize = "#00000000"
theme.tasklist_bg_focus = c.primary_container
theme.tasklist_bg_urgent = c.error
theme.tasklist_shape = rounded(math.floor(cfg.cell / 3))
theme.tasklist_fg_normal = c.on_surface_variant
theme.tasklist_fg_focus = c.on_primary_container
theme.tasklist_fg_minimize = c.outline

-- Layout icons
for k, v in pairs(theme) do
	if type(k) == "string" and k:match("^layout_") then
		theme[k] = gears.color.recolor_image(v, c.on_surface_variant)
	end
end

beautiful.init(theme)
