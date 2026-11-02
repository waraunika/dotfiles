local vars = require("binds.variables")
local script = vars.mods.mainMod .. "+" .. vars.mods.scriptMod

local keymaps = {
	{ "W", "scripts/waybar/waybar_launch.sh" },
	{ "K", "scripts/waybar/waybar_kill.sh" },
	{ "R", "scripts/record_audioless.sh" },
	{ "A", "scripts/record_audiofull.sh" },
	{ "B", "scripts/rest toggle" },
	{ "B", "scripts/rest start", { vars.mods.priMod } },
	{ "B", "scripts/rest stop", { vars.mods.secMod } },
	{ "M", "~/scripts/rofi-music" },
	{ "T", "~/scripts/wallpaper" },
	{
		"B",
		"scripts/rest status",
		{ vars.mods.priMod, vars.mods.secMod },
	},
}

for _, map in ipairs(keymaps) do
	local key, cmd, extra_mods = map[1], map[2], map[3]
	local mods = script

	if extra_mods then
		mods = mods .. " + " .. table.concat(extra_mods, " + ")
	end

	hl.bind(mods .. " + " .. key, hl.dsp.exec_cmd(cmd))
end

hl.bind(vars.mods.mainMod .. "+ period", hl.dsp.exec_cmd("$HOME/scripts/wofi-emoji"))
