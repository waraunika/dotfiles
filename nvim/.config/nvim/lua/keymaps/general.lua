local keymaps = {
	-- window navigation
	{
		{ "n", "v", "i" },
		"<C-h>",
		"<C-w>h",
		"Go to left window",
	},
	{
		{ "n", "v", "i" },
		"<C-j>",
		"<C-w>j",
		"Go to upper window",
	},
	{
		{ "n", "v", "i" },
		"<C-k>",
		"<C-w>k",
		"Go to below window",
	},
	{
		{ "n", "v", "i" },
		"<C-l>",
		"<C-w>l",
		"Go to right window",
	},

	-- Save file
	{
		{ "n", "i" },
		"<C-s>",
		"<cmd>w<CR>",
		"Save file",
	},

	-- save file with no auto commands
	{
		"n",
		"<A-s>",
		"<cmd>noautocmd w<CR>",
		"Save file without auto-formatting",
	},

	-- Shift + Tab to remove indentation
	{
		"n",
		"<S-Tab>",
		"<<",
		"Remove indentation inline",
	},
	{
		"i",
		"<S-Tab>",
		"<C-d>",
		"Remove indentation inline",
	},
	{
		"v",
		"<S-Tab>",
		"<gv",
		"Remove indentation inline",
	},

	-- Quit file
	{
		{ "n", "i" },
		"<C-q>",
		"<cmd>q<CR>",
		"Quit file",
	},

	-- Delete single character without copying
	{
		{ "n", "v" },
		"x",
		'"_x',
		"Delete character without copying",
	},

	-- Vertical scroll and center
	{
		"n",
		"<C-d>",
		"<C-d>zz",
		"Scroll down and center",
	},
	{ "n", "<C-u>", "<C-u>zz", "Scroll up and center" },

	-- Search navigation and center
	{
		"n",
		"n",
		"nzzzv",
		"Next search result and center",
	},
	{
		"n",
		"N",
		"Nzzzv",
		"Previous search result and center",
	},

	-- Window resizing
	{
		"n",
		"<Up>",
		":resize -2<CR>",
		"Decrease window height",
	},
	{
		"n",
		"<Down>",
		":resize +2<CR>",
		"Increase window height",
	},
	{
		"n",
		"<Left>",
		":vertical resize -2<CR>",
		"Decrease window width",
	},
	{
		"n",
		"<Right>",
		":vertical resize +2<CR>",
		"Increase window width",
	},

	-- Buffer management
	{
		{ "n", "i" },
		"<leader><Tab>",
		":bnext<CR>",
		"Next buffer",
	},
	{
		{ "n", "i" },
		"<leader><S-Tab>",
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

	-- Window management
	{
		{ "n", "i" },
		"<leader>v",
		"<C-w>v",
		"Split window vertically",
	},
	{
		"n",
		"<leader>h",
		"<C-w>s",
		"Split window horizontally",
	},
	{
		"n",
		"<leader>se",
		"<C-w>=",
		"Make split windows equal size",
	},
	{
		"n",
		"<leader>w",
		":close<CR>",
		"Close window",
	},

	-- Tab management
	{
		{ "n", "i" },
		"<leader>to",
		":tabnew<CR>",
		"Open new tab",
	},
	{
		"n",
		"<leader>tw",
		":tabclose<CR>",
		"Close tab",
	},
	{
		"n",
		"<leader>tn",
		":tabn<CR>",
		"Next tab",
	},
	{
		"n",
		"<leader>tp",
		":tabp<CR>",
		"Previous tab",
	},

	-- Toggle line wrapping
	{
		{ "n", "i" },
		"<leader>lw",
		"<cmd>set wrap!<CR>",
		"Toggle line wrap",
	},

	-- Stay in indent mode
	{
		"v",
		"<",
		"<gv",
		"Indent left and reselect",
	},
	{
		"v",
		">",
		">gv",
		"Indent right and reselect",
	},

	-- Keep last yanked when pasting in visual mode
	{
		"v",
		"p",
		'"_dP',
		"Paste without replacing register",
	},
	{
		"n",
		"]d",
		function()
			vim.diagnostic.config({
				jump = {
					on_jump = function()
						vim.diagnostic.open_float()
					end,
				},
			})
		end,
		"Open floating diagnostic message",
	},
	{
		"n",
		"<leader>q",
		vim.diagnostic.setloclist,
		"Open diagnostics list",
	},
}

return keymaps
