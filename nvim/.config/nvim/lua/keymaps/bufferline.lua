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
		"<A-w>",
		":Bdelete!<CR>",
		"Close buffer",
	},
	{
		"n",
		"<A-q>",
		"<cmd>BufferLineMovePrev<CR>",
		"Move current buffer to left",
	},
	{
		"n",
		"<A-e>",
		"<cmd>BufferLineMoveNext<CR>",
		"Move current buffer to right",
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
