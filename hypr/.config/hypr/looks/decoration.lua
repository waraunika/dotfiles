hl.config({
	decoration = {
		rounding = 5,
		rounding_power = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 0.9,
		dim_inactive = true,
		dim_strength = 0.1,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee0a0a0a,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 4,
			vibrancy = 0.1696,
		},
	},
})
