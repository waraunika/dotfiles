return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"c",
				"cpp",
				"javascript",
				"lua",
				"tsx",
				"typescript",
				"svelte",
				"python",
				"vimdoc",
				"vim",
				"regex",
				"sql",
				"toml",
				"json",
				"gitignore",
				"yaml",
				"make",
				"cmake",
				"markdown",
				"markdown_inline",
				"bash",
				"css",
				"html",
				"m",
				"verilog",
				"systemverilog",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		},
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },

		init = function()
			vim.g.no_plugin_maps = true
		end,

		config = function()
			local select = require("nvim-treesitter-textobjects.select")
			local move = require("nvim-treesitter-textobjects.move")

			vim.keymap.set("o", "ib", function()
				select.select_textobject("@code_cell.inner", "textobjects")
			end, { desc = "Inner code cell" })
			vim.keymap.set({ "x", "o" }, "ab", function()
				select.select_textobject("@code_cell.outer", "textobjects")
			end, { desc = "Around code cell" })
			vim.keymap.set({ "n", "x", "o" }, "]b", function()
				move.goto_next_start("@code_cell.inner", "textobjects")
			end, { desc = "Next code cell" })
			vim.keymap.set({ "n", "x", "o" }, "[b", function()
				move.goto_previous_start("@code_cell.inner", "textobjects")
			end, { desc = "Previous code cell" })
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPost",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			enable = true,
			max_lines = 3,
			min_window_height = 0,
			line_numbers = true,
			multiline_threshold = 1,
			trim_scope = "outer",
			mode = "cursor",
			zindex = 20,
		},
	},
}
