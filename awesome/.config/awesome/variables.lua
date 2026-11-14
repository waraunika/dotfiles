--- binds/variables.lua
--- Single place for modifiers, apps and monitor names
local vars = {}

vars.mods = {
	mainMod = "Mod4", -- Super/Logo
	priMod = "Control", -- CTRL: first alternate
	secMod = "Shift", -- SHIFT: opposite / secondary variant
	scriptMod = "Mod1", -- ALT: for scripts
}

vars.apps = {
	terminal = "kitty",
	fileManager = "kitty yazi",
	fileManager1 = "pcmanfm",
	menu = "rofi -show drun",
	menu2 = "~/.config/rofi/launchers/type-1/launcher.sh",
	browser = "flatpak run org.mozilla.firefox",
	editor = "kitty nvim",
	calendar = "thunderbird",
}

vars.monitors = {
	left = "HDMI-A-0",
	right = "eDP",
}

vars.bar = {
	-- looks
	floating = false,
	margin = 2, -- screen edge and bar gap
	gap = 4, -- gap between windows
	width = 48, -- bar thickness
	radius = 14, -- bar roundedness
	padding = 6, -- bar and content gap
	pill_radius = 14, -- corner radius of grouped pill
	pill_padding = 10, -- space between items
	spacing = 8,
	cell = 30,
	opacity = 0.92,

	font = "JetBrainsMono Nerd Font Propo",
	font_size = 9,
	icon_size = 12,
	show_values = true,

	notif_interval = 5,

	top = { "layout", "taglist" },
	middle = { "tasklist" },
	bottom = { { "tray", "rest", "notifications", "network", "volume", "battery" }, "clock" },

	systray = true,
	battery = "BAT1",
	rest_interval = 10,
	network_interval = 5,
	clock = {
		hour = "%H",
		minute = "%M",
		tooltip = "%A, %d %B %Y",
	},

	tasklist = {
		chars = 28,
		filter = "currenttags", -- or "alltags" / "allscreen" to list every client on the screen
		direction = "east", -- reads bottom to top; "east" reads top to bottom
		font_size = 9.5,
		icon_size = 20,
		pad = 6,
		gap = 8,
		terminals = { kitty = true },
	},
}

return vars
