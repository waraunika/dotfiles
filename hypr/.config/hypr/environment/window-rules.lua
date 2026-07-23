--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

hl.layer_rule({
	name = "rofi-popup",
	match = { namespace = "rofi" },
	animation = "slide right",
	dim_around = true,
})

hl.layer_rule({
	name = "notification-animations",
	match = { namespace = "swaync-control-center" },
	animation = "slide top",
	dim_around = true,
})

hl.window_rule({
	name = "dolphin-copy-progress",
	match = {
		class = "org.kde.dolphin",
		title = "Copying — Dolphin",
	},

	float = true,
})

hl.window_rule({
	name = "PiP rule",
	match = {
		class = "firefox",
		title = "Picture-in-Picture",
	},

	float = true,
	size = { "monitor_w / 3", "monitor_h / 3" },
	-- move = { "monitor_w * 0.5 + 15", "(monitor_h /2)" }
	move = { "monitor_w * 2/3", "monitor_h * 2/3" },
})

hl.window_rule({
	name = "Octave graph",
	match = {
		class = "org.octave.Octave",
		title = "Figure 1",
	},

	float = true,
	size = { "monitor_w / 2", "monitor_h / 2" },
	-- move = { "monitor_w * 0.5 + 15", "(monitor_h /2)" }
	move = { "monitor_w * 1/2", "monitor_h * 1/2" },
})

hl.window_rule({
	name = "Octave graph",
	match = {
		class = "octave-gui",
		title = "Figure 1",
	},

	float = true,
	size = { "monitor_w / 2", "monitor_h / 2" },
	-- move = { "monitor_w * 0.5 + 15", "(monitor_h /2)" }
	move = { "monitor_w * 1/2", "monitor_h * 1/2" },
})

hl.window_rule({
	name = "Matplotplusplus graph",
	match = {
		class = "gnuplot_qt",
		title = "Figure 1",
	},

	float = true,
	size = { "monitor_w / 2", "monitor_h / 2" },
	-- move = { "monitor_w * 0.5 + 15", "(monitor_h /2)" }
	move = { "monitor_w * 1/4", "monitor_h * 1/4" },
})

hl.window_rule({
	name = "Discord in 10th workspace spawn",
	match = {
		class = "vesktop",
	},

	workspace = 10,
})

hl.window_rule({
	name = "GTKWave floating",
	match = {
		class = "gtkwave",
		title = "gtkwave",
	},

	float = true,
	size = { "monitor_w / 4", "monitor_h / 4" },
	move = { "monitor_w * 1/4", "monitor_h * 1/4" },
})

hl.window_rule({
	name = "Steam Friend List Floating",
	match = {
		class = "steam",
		title = "Friends List",
	},

	float = true,
	size = { "monitor_w / 4", "monitor_h / 4" },
})

hl.window_rule({
	name = "Stem in 9th workspace spawn",
	match = {
		class = "steam",
	},

	workspace = 9,
})

hl.window_rule({
	name = "Whatsapp call floating",
	match = {
		class = "firefox",
		title = "WhatsApp call — Original profile — Mozilla Firefox",
	},

	float = true,
	size = { "monitor_w / 4", "monitor_h / 4" },
	move = { "monitor_w * 1/4", "monitor_h * 1/4" },
})

hl.window_rule({
	name = "Firefox library floating",
	match = {
		class = "firefox",
		title = "Library",
	},

	float = true,
	size = { "monitor_w / 2", "monitor_h / 2" },
	move = { "monitor_w * 1/4", "monitor_h * 1/4" },
})

hl.window_rule({
	name = "Thunderbird new event floating",
	match = {
		class = "org.mozilla.Thunderbird",
		title = "New Event",
	},

	float = true,
	size = { "monitor_w / 2", "monitor_h / 2" },
	move = { "monitor_w * 1/4", "monitor_h * 1/4" },
})
