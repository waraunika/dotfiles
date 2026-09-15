local vars = require("binds.variables")
local monitors = { vars.monitors.laptop, vars.monitors.external }
local seen_default = {}
local workspace_count = 10

for i = 1, workspace_count do
	local monitor = monitors[((i - 1) % #monitors) + 1]

	hl.workspace_rule({
		workspace = tostring(i),
		monitor = monitor,
		default = not seen_default[monitor],
	})

	seen_default[monitor] = true
end
