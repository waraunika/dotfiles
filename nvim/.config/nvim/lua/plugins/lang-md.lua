-- https://github.com/lukas-reineke/headlines.nvim

return {
	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true,
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = "cd app && yarn install",

		init = function()
			-- enable only on md and txt files
			vim.g.mkdp_filetype = { "markdown", "text" }
			vim.g.mkdp_command_for_global = 0

			-- refresh on save/leaving insert mode
			vim.g.mkdp_refresh_show = 1

			-- open in firefox specifically
			vim.g.mkdp_browser = "firefox"

			-- each markdown file in its own type
			vim.g.mkdp_combine_preview = 0
			vim.g.mkdp_auto_close = 1
			vim.g.mkdp_auto_start = 0

			-- enable KaTeX, Mermaid, PlantUML, sequence + flowchart
			vim.g.mkdp_preview_options = {
				mkit = {},
				katex = {},
				uml = {},
				sequence_diagrams = {},
				flowchart_diagrams = {},
				disable_sync_scroll = 0,
				sync_scroll_type = "middle",
				hide_yaml_meta = 1,
				content_editable = false,
				disable_filename = 0,
				toc = {},
			}

			vim.g.mkdp_theme = "dark"

			-- refresh lag on 100 ms
			vim.opt.updatetime = 100
		end,
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "md" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons", -- swap for 'nvim-mini/mini.icons' if you use mini.nvim
		},

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

	{
		"causality-enjoyer/image-cursor.nvim",
		ft = { "markdown" },
		config = function()
			require("image-cursor").setup({
				-- which filetypes to watch for image links in
				filetypes = { "markdown" },
				-- max preview size, unit: terminal cells
				max_width_cells = 70,
				max_height_cells = 20,
				-- min usable cell height
				min_height_cells = 6,
				-- ratio for cell width/height for your terminal, defaults to 0.5
				cell_aspect = nil,

				-- keymap to mannually toggle the preview for current line
				-- Set to false to disable
				keys = {
					toggle = "<leader>ii",
				},
			})
		end,
	},
}
