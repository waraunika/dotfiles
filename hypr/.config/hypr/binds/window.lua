local vars = require("binds.variables")
local mainMod = vars.mods.mainMod

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen("maximized", "toggle"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. "+" .. vars.mods.secMod .. "+ T", hl.dsp.group.toggle())

hl.bind(
	mainMod .. "+" .. vars.mods.priMod .. "+" .. "D",
	hl.dsp.exec_cmd("hyprctl eval \"hl.config({ general = { layout = 'dwindle' } })\"")
)
hl.bind(
	mainMod .. "+" .. vars.mods.priMod .. "+" .. "M",
	hl.dsp.exec_cmd("hyprctl eval \"hl.config({ general = { layout = 'master' } })\"")
)
hl.bind(
	mainMod .. "+" .. vars.mods.priMod .. "+" .. "S",
	hl.dsp.exec_cmd("hyprctl eval \"hl.config({ general = { layout = 'scrolling' } })\"")
)

hl.bind(mainMod .. "+ left", hl.dsp.layout("colresize +0.1"))
hl.bind(mainMod .. "+ right", hl.dsp.layout("colresize -0.1"))
hl.bind(mainMod .. "+ up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. "+ down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. "+ H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. "+ L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. "+ K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. "+ J", hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. "+ " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. "+ " .. vars.mods.priMod .. " + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 3%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 3%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

local MAX_ZOOM = 3
local MIN_ZOOM = 1
local ZOOM_TOGGLE_FACTOR = 1.5

---@param offset number
---@return nil
local function zoom(offset)
	local current = hl.get_config("cursor.zoom_factor")
	if offset ~= nil then
		current = current + offset
	elseif current ~= MIN_ZOOM then
		current = MIN_ZOOM
	else
		current = ZOOM_TOGGLE_FACTOR
	end
	current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
	hl.config({ cursor = { zoom_factor = current } })
end

hl.bind("SUPER + equal", function()
	zoom(0.5)
end)
hl.bind("SUPER + minus", function()
	zoom(-0.5)
end)

hl.bind(mainMod .. "+" .. vars.mods.priMod .. " + mouse_down", function()
	zoom(0.5)
end)
hl.bind(mainMod .. "+" .. vars.mods.priMod .. " + mouse_up", function()
	zoom(-0.5)
end)
