local keymaps = {
	{
		"n",
		"<leader>pf",
		function()
			Snacks.picker.files()
		end,
		"[P]ick [F]iles",
	},
	{
		"n",
		"<leader>pg",
		function()
			Snacks.picker.grep()
		end,
		"[P]ick [G]rep",
	},
	{
		"n",
		"<leader>pr",
		function()
			Snacks.picker.recent()
		end,
		"[P]ick [R]ecent files",
	},
	{
		"n",
		"<leader>pb",
		function()
			Snacks.picker.buffers()
		end,
		"[P]ick [B]uffers",
	},
	{
		"n",
		"<leader>ps",
		function()
			Snacks.picker.lsp_symbols()
		end,
		"[P]ick LSP [S]symbols",
	},
	{
		"n",
		"<leader>p/",
		function()
			Snacks.picker.grep_buffers()
		end,
		"[P]ick grep open buffers",
	},
}

return keymaps
