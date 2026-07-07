vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window", silent = true })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", silent = true })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", silent = true })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window", silent = true })


keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- control s to save file
keymap('n', '<C-s>', '<cmd> w <CR>', opts)
keymap('i', '<C-s>', '<cmd> w <CR>', opts)

-- save file without auto formatting
keymap('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts)

-- quit file
keymap('n', '<C-q>', '<cmd> q <CR>', opts)

-- delete single character without copying into register
keymap('n', 'x', '"_x', opts)

-- vertical scroll and center
keymap('n', '<C-d>', '<C-d>>zz', opts)
keymap('n', '<C-u>', '<C-u>>zz', opts)

keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)

keymap('n', '<Up>', ':resize -2<CR>', opts)
keymap('n', '<Down>', ':resize +2<CR>', opts)
keymap('n', '<Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<Right>', ':vertical resize +2<CR>', opts)

-- buffer management
keymap('n', '<leader><Tab>', ':bnext<CR>', opts)
keymap('n', '<leader><S-Tab>', ':bprevious<CR>', opts)
keymap('n', '<C-w>', ':Bdelete!<CR>', opts) -- close buffer
keymap('n', '<leader>b', '<cmd> enew <CR>', opts) -- open buffer

-- window management
keymap('n', '<leader>v', '<C-w>v', opts) -- split vertically
keymap('n', '<leader>h', '<C-w>s', opts) -- split horizontally
keymap('n', '<leader>se', '<C-w>=', opts) -- make split windows equal in size
keymap('n', '<leader>w', ':close<CR>', opts) -- close window 

-- tab management
keymap('n', '<leader>to', ':tabnew<CR>', opts) -- new empty tab
keymap('n', '<leader>tw', ':tabclose<CR>', opts) -- close tab
keymap('n', '<leader>tn', ':tabn<CR>', opts) -- next tab
keymap('n', '<leader>tp', ':tabp<CR>', opts) -- previous tab

-- toggle line wrapping
keymap('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- keep last yanked when pasting
keymap('v', 'p', '"_dP', opts)

-- diagnostic keymaps
keymap('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous diagnostic message' })

keymap('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next diagnostic message' })

keymap('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
