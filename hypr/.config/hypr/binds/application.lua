local vars = require("binds.variables")
local mainMod = vars.mods.mainMod

local keymaps = {
	-- format: { key, cmd, mods (that are optional)}
	{ "Return", vars.apps.terminal },
	{
		"Return",
		"[float] kitty",
		{ vars.mods.priMod },
	},
	{ "B", vars.apps.browser },
	{ "D", "emacs" },
	{ "C", vars.apps.calendar },
	{ "E", vars.apps.fileManager },
	{ "E", vars.apps.fileManager1, { vars.mods.priMod } },
	{ "N", vars.apps.editor },
	{ "S", "prime-run steam" },
	{ "V", "vesktop" },
	{ "W", "whatsie" },
	{ "X", "sioyek --new-instance" },
	{ "Y", vars.apps.browser .. " youtube.com" },
	{
		"M",
		"command -v hyprshutdown > /dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'",
		{ vars.mods.priMod, vars.mods.secMod },
	},
}

for _, map in ipairs(keymaps) do
	local key, cmd, extra_mods = map[1], map[2], map[3]
	local mods = mainMod

	if extra_mods then
		mods = mods .. " + " .. table.concat(extra_mods, " + ")
	end

	hl.bind(mods .. " + " .. key, hl.dsp.exec_cmd(cmd))
end

-- for switching to steam/discord even when not spawning:
hl.bind(mainMod .. "+ S", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. "+ V", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. "+ W", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. "+ C", hl.dsp.focus({ workspace = 4 }))
