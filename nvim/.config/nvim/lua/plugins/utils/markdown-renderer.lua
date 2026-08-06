-- plugins/render-markdown.lua
return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "md" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons", -- swap for 'nvim-mini/mini.icons' if you use mini.nvim
		},
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			latex = {
				enabled = true,
				converter = { "latex2text", "utftex" },
				-- requires `pylatexenc` python package and `libtexprintf` package respectively
				position = "inline",
				block = true,
				highlight = "RenderMarkdownMath",
				position = "center",
			},
			completions = {
				lsp = { enabled = true },
			},
		},
	},
}
