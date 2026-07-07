local vars = require("binds.variables")
local mainMod = vars.mods.mainMod

hl.bind(mainMod .. "+" .. vars.mods.priMod .. "+ H", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. "+" .. vars.mods.priMod .. "+ L", hl.dsp.layout("swapcol r"))

hl.bind(mainMod .. "+" .. vars.mods.priMod .. "+ period", hl.dsp.layout("move +200"))
hl.bind(mainMod .. "+" .. vars.mods.secMod .. "+ period", hl.dsp.layout("move -200"))