local keymaps = {
	{
		"n",
		"<leader>ngs",
		":Neotree float git_status<CR>",
		"Open git status window",
	},
	{ "n", "<leader>e", ":Neotree toggle position=right<CR>", "Toggle file explorer" },
	{
		"n",
		"\\",
		":Neotree reveal<CR>",
		"Reveal file in explorer",
	},
}

return keymaps
