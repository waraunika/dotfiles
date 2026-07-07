-- https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
local vars = require("binds.variables")

hl.bind(vars.mods.mainMod .. " + comma", hl.dsp.layout("swapwithmaster ignoremaster"))

hl.bind(vars.mods.mainMod .. "+" .. vars.mods.priMod .. " + comma", hl.dsp.layout("focusmaster master"))
hl.bind(vars.mods.mainMod .. "+" .. vars.mods.secMod .. " + comma", hl.dsp.layout("cyclenext"))
hl.bind(vars.mods.mainMod .. "+" .. vars.mods.priMod .. "+" .. vars.mods.secMod .. " + comma", hl.dsp.layout("cycleprev"))


hl.bind(vars.mods.mainMod .. "+" .. vars.mods.priMod .. " + period", hl.dsp.layout("addmaster"))
hl.bind(vars.mods.mainMod .. "+" .. vars.mods.secMod .. " + period", hl.dsp.layout("removemaster"))

hl.bind(vars.mods.mainMod .. "+ bracketleft", hl.dsp.layout("orientationleft"))
hl.bind(vars.mods.mainMod .. "+ bracketright", hl.dsp.layout("orientationright"))