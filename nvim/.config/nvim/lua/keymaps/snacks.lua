local keymap = vim.keymap.set

local snacks_keys = {
	{
		"n",
		"<leader>pf",
		function()
			Snacks.picker.files()
		end,
		desc = "[P]ick [F]iles",
	},
	{
		"n",
		"<leader>pg",
		function()
			Snacks.picker.grep()
		end,
		desc = "[P]ick [G]rep",
	},
	{
		"n",
		"<leader>pr",
		function()
			Snacks.picker.recent()
		end,
		desc = "[P]ick [R]ecent files",
	},
	{
		"n",
		"<leader>pb",
		function()
			Snacks.picker.buffers()
		end,
		desc = "[P]ick [B]uffers",
	},
	{
		"n",
		"<leader>ps",
		function()
			Snacks.picker.lsp_symbols()
		end,
		desc = "[P]ick LSP [S]symbols",
	},
	{
		"n",
		"n",
		"<leader>p/",
		function()
			Snacks.picker.grep_buffers()
		end,
		desc = "[P]ick grep open buffers",
	},
}

return keymap
