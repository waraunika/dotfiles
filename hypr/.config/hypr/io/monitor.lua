------------------
---- MONITORS ----
------------------
local vars = require("binds.variables")
local monitors = vars.monitors

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({ output = monitors.laptop, mode = "1920x1080@144", position = "0x0", scale = "1" })

-- hl.monitor({ output = "HDMI-A-1", mirror = "eDP-1", position = "-1920x0", mode = "1920x1080", scale = "1" })

hl.monitor({ output = monitors.external, position = "-1920x0", mode = "1920x1080@100", scale = "1" })
