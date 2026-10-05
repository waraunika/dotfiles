-- https://github.com/nvim-treesitter/nvim-treesitter
return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	-- main = 'nvim-treesitter.configs', -- Sets main module to use for opts
	-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
	opts = {
		ensure_installed = {
			"c",
			"cpp",
			"javascript",
			"lua",
			"tsx",
			"typescript",
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
		-- Autoinstall languages that are not installed
		auto_install = true,
		highlight = {
			enable = true,
		},
		indent = { enable = true },
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		init = function()
			vim.g.no_plugin_maps = true -- avoid built-in ftplugin mapping conflicts
		end,
		config = function()
			vim.keymap.set({ "o" }, "ib", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@code_cell.inner", "textobjects")
			end, { desc = "Inner code cell" })

			vim.keymap.set({ "x", "o" }, "ab", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@code_cell.outer", "textobjects")
			end, { desc = "Around code cell" })

			vim.keymap.set({ "n", "x", "o" }, "]b", function()
				require("nvim-treesitter-textobjects.move").goto_next_start("@code_cell.inner", "textobjects")
			end, { desc = "Next code cell" })

			vim.keymap.set({ "n", "x", "o" }, "[b", function()
				require("nvim-treesitter-textobjects.move").goto_previous_start("@code_cell.inner", "textobjects")
			end, { desc = "Previous code cell" })
		end,
	},

	{
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
	},
}
