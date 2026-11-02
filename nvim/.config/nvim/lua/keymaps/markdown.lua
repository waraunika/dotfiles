local keymaps = {
	{ "n", "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", "Toggle Markdown render" },
	{ "n", "mp", "<cmd>MarkdownPreview<CR>", "Preview Markdown (split)" },
	{ "v", "<C-B>", [[c**<C-r>"**<Esc>]], "Markdown wrap in **...**" },
	{ "i", "<C-B>", "****<Left><Left>", "Insert Markdown Bold **|**" },
	{ "v", "<C-I>", [[c*<C-r>"*<Esc>]], "Markdown wrap in **...**" },
}

for i = 1, #keymaps do
	vim.keymap.set(keymaps[i][1], keymaps[i][2], keymaps[i][3], { desc = keymaps[i][4], ft = { "markdown" } })
end
