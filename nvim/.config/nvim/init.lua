require("config.options")

require("keymaps.general")
require("keymaps.latex")

require("config.lazy")

vim.g.python3_host_prog = vim.fn.expand('~/.local/bin/pynvim-python')
