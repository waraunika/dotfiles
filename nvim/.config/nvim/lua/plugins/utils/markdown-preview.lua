return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = "cd app && npm install",

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

	keys = {
		{ "<C-p>", "<cmd>MarkdownPreview<cr>", ft = "markdown", remap = true, desc = "Start Markdown preview" },
		{ "<C-p>", "<cmd>MarkdownPreviewStop<cr>", ft = "markdown", remap = true, desc = "Stop Markdown preview" },
	},
}
