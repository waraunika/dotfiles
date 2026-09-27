local keymaps = {
	{
		"n",
		"<A-Tab>",
		":bnext<CR>",
		"Next buffer",
	},
	{
		"n",
		"<A-S-Tab>",
		":bprevious<CR>",
		"Previous buffer",
	},
	{
		"n",
		"<C-w>",
		":Bdelete!<CR>",
		"Close buffer",
	},
	{
		"n",
		"<leader>b",
		"<cmd>enew<CR>",
		"Open new buffer",
	},
}
for i = 1, 9 do
	table.insert(keymaps, {
		"n",
		"<A-" .. i .. ">",
		"<cmd>BufferLineGoToBuffer " .. i .. "<CR>",
		"Go to buffer-" .. i,
	})
end

return keymaps
