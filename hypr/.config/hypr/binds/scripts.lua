local vars = require("binds.variables")
local script = vars.mods.mainMod .. "+" .. vars.mods.scriptMod

hl.bind(script .. " + B", hl.dsp.exec_cmd(".config/waybar/scripts/launch.sh"))
hl.bind(script .. " + K", hl.dsp.exec_cmd(".config/waybar/scripts/kill.sh"))

hl.bind(script .. "+ A", hl.dsp.exec_cmd(".config/hypr/scripts/record-soundful.sh"))
hl.bind(script .. "+ R", hl.dsp.exec_cmd(".config/hypr/scripts/record-soundless.sh"))

hl.bind(script .. "+ E", hl.dsp.exec_cmd(".config/hypr/scripts/rest-reminder.sh"))