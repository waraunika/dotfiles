vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true

vim.keymap.set("i", "<Left>", "<Left>", { buffer = true, desc = "Fix SQL drill out mapping" })
vim.keymap.set("i", "<Right>", "<Right>", { buffer = true, desc = "Fix SQL drill in mapping" })
