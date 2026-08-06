require("config.options")

require("keymaps.general")
require("keymaps.latex")
require("keymaps.lsp")
require("keymaps.markdown")
require("keymaps.snacks")

require("config.lazy")

vim.g.python3_host_prog = vim.fn.expand("~/.local/bin/pynvim-python")
