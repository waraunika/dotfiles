vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set
local defaults = { silent = true, noremap = true }

local function opts(description, filetype)
	defaults.desc = description
	if type(filetype) == "string" or type(filetype) == "table" then
		defaults.filetype = filetype
	end

	return defaults
end

local modules = {
	"keymaps.general",
	"keymaps.latex",
	"keymaps.lsp",
	"keymaps.markdown",
	"keymaps.neotree",
	"keymaps.snacks",
}

for _, mod in ipairs(modules) do
	local keymaps = require(mod)

	if type(keymaps) == "table" then
		for _, keymap in ipairs(keymaps) do
			map(keymap[1], keymap[2], keymap[3], opts(keymap[4]))
		end
	end
end
