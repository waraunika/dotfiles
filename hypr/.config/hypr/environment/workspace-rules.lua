local vars = require("binds.variables")
local monitors = { vars.monitors.laptop, vars.monitors.external }
local seen_default = {}
local workspace_count = 10

for i = 1, workspace_count do
	local monitor = monitors[(i % #monitors) + 1]

	hl.workspace_rule({
		workspace = tostring(i),
		monitor = monitor,
		default = not seen_default[monitor],
	})

	if i % 2 ~= 0 then
		hl.window_rule({
			name = "monitor having 33% tile width",
			workspace = tostring(i),
			scrolling_width = 0.33333,
		})
	end

	seen_default[monitor] = true
end
