local vars = require("binds.variables")
local mainMod = vars.mods.mainMod

hl.bind(vars.mods.mainMod .. " + SPACE", hl.dsp.exec_cmd(vars.apps.menu2))
hl.bind(vars.mods.mainMod .. "+" .. vars.mods.priMod .. " + SPACE", hl.dsp.exec_cmd("hyprlauncher"))

hl.bind(vars.mods.priMod .. "+" .. vars.mods.secMod .. "+ 1",
	hl.dsp.exec_cmd('grim -g "$(slurp)" "$HOME/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png"'))
hl.bind(mainMod .. "+" .. vars.mods.secMod .. "+ S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))

hl.bind(mainMod .. "+ period", hl.dsp.exec_cmd("$HOME/scripts/wofi-emoji"))

hl.bind(mainMod .. "+" .. vars.mods.secMod .. "+ H", hl.dsp.exec_cmd("hyprpicker -a"))

hl.bind(mainMod .. "+" .. vars.mods.secMod .. "+ L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. "+" .. vars.mods.secMod .. "+ P", hl.dsp.exec_cmd("wlogout --buttons-per-row 4"))
