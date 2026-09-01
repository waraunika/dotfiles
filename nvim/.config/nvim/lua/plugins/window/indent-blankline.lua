-- https://github.com/lukas-reineke/indent-blankline.nvim
return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPost", "BufNewFile" },
	---@module "ibl"
	---@type ibl.config
	opts = {
		indent = {
			char = "│", -- the vertical bar character
		},
		scope = {
			enabled = true, -- highlight the bar for the current scope more brightly
			show_start = false, -- don't underline the scope's start line
			show_end = false, -- don't underline the scope's end line
		},
		exclude = {
			filetypes = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"Trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
			},
		},
	},
}
