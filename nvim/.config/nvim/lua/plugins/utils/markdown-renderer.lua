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
				converter = { "utftex", "pylatexenc" },
				-- requires `libtexprintf` package and `pylatexenc` python package respectively
				position = "center",
				block = true,
				highlight = "RenderMarkdownMath",
			},
			completions = {
				lsp = { enabled = true },
			},
		},
	},
}
