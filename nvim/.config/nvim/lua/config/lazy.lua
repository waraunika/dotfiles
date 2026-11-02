-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	require("plugins.ui-noice"),
	require("plugins.ui-snacks"),
	require("plugins.ui-bufferline"),
	require("plugins.ui-lualine"),
	require("plugins.ui-neotree"),

	--require "plugins.theme-onedark-olimorris",
	--require "plugins.theme-onedark",
	--require("plugins.theme-nord"),
	require("plugins.theme-everforest"),

	require("plugins.editor-autopairs"),
	require("plugins.editor-completion"),
	require("plugins.editor-conform"),
	require("plugins.editor-lsp"),
	require("plugins.editor-session"),
	require("plugins.editor-treesitter"),

	require("plugins.lang-cpp"),
	require("plugins.lang-vim"),
	require("plugins.lang-md"),
	require("plugins.lang-php"),
	require("plugins.lang-py"),
	require("plugins.lang-tex"),
	require("plugins.lang-csv"),

	require("plugins.utils-image-preview"),
	require("plugins.utils-img-clip"),

	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
