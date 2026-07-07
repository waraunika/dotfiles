-- https://github.com/folke/snakcs.nvim

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = false} ,
    indent = { enabled = false },
    input = { enabled = true },
    picker = {
      enabled = true,
      sources = {
        files = {
          hidden = true
        }
      }
    },
    notifier = { enabled = false },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    { "<leader>pf", function() Snacks.picker.files() end, desc = "[P]ick [F]iles" },
    { "<leader>pg", function() Snacks.picker.grep() end, desc = "[P]ick [G]rep" },
    { "<leader>pr", function() Snacks.picker.recent() end, desc = "[P]ick [R]ecent files" },
    { "<leader>pb", function() Snacks.picker.buffers() end, desc = "[P]ick [B]uffers" },
    { "<leader>ps", function() Snacks.picker.lsp_symbols() end, desc = "[P]ick LSP [S]symbols" },
    { "<leader>p/", function() Snacks.picker.grep_buffers() end, desc = "[P]ick grep open buffers" },
  }
}
