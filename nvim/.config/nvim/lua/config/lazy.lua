-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  require 'plugins.window.noice',
  require 'plugins.window.neo-tree',
  require 'plugins.window.snacks',
  require 'plugins.window.bufferline',
  require 'plugins.window.lualine',
  require 'plugins.window.greeter',

  --require "plugins.colortheme.onedark-olimorris",
  --require "plugins.colortheme.onedark-navarasu",
	require "plugins.colortheme.nord-shaunsingh",

  require 'plugins.workflow.treesitter',
  require 'plugins.workflow.telescope',
  require 'plugins.workflow.lsp',
  require 'plugins.workflow.completion',

	require 'plugins.language.tex',
  require 'plugins.language.markdown',

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
