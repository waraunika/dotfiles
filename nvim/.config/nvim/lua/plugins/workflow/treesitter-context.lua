-- https://github.com/nvim-treesitter/nvim-treesitter-context
return {
	"nvim-treesitter/nvim-treesitter-context",
	event = "BufReadPost",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		enable = true,
		max_lines = 3, -- cap how many sticky lines show at once (0 = unlimited)
		min_window_height = 0,
		line_numbers = true,
		multiline_threshold = 1, -- collapse a long context line to 1 line
		trim_scope = "outer", -- drop the outermost scope first if too long
		mode = "cursor", -- context follows cursor position (not just top visible line)
		separator = nil, -- set e.g. "─" for a divider under the sticky lines
		zindex = 20,
	},
}
