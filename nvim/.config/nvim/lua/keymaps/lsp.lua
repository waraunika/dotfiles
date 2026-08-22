-- ========== LSP AND DIAGNOSTICS KEYMAPS ==========
-- These are also defined in lsp.lua's on_attach, but global ones are kept here
local lsp_opts = { noremap = true, silent = true }

-- Open diagnostic floating window
vim.keymap.set(
	"n",
	"<leader>e",
	vim.diagnostic.open_float,
	vim.tbl_extend("force", lsp_opts, { desc = "Open diagnostic float" })
)

-- Show line diagnostics only
vim.keymap.set("n", "<leader>dl", function()
	vim.diagnostic.open_float({ scope = "line" })
end, vim.tbl_extend("force", lsp_opts, { desc = "Line diagnostics" }))

-- LSP actions (these work if LSP is attached)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", lsp_opts, { desc = "Go to definition" }))
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", lsp_opts, { desc = "Go to declaration" }))
vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", lsp_opts, { desc = "Go to references" }))
vim.keymap.set(
	"n",
	"gi",
	vim.lsp.buf.implementation,
	vim.tbl_extend("force", lsp_opts, { desc = "Go to implementation" })
)
vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", lsp_opts, { desc = "Hover documentation" }))
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", lsp_opts, { desc = "Signature help" }))
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", lsp_opts, { desc = "Rename symbol" }))
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", lsp_opts, { desc = "Code action" }))

-- Format document
vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format({ async = true })
end, vim.tbl_extend("force", lsp_opts, { desc = "Format document" }))

-- Show LSP status
vim.keymap.set("n", "<leader>ls", function()
	local clients = vim.lsp.get_clients()
	local msg = "Active LSP clients: "
	for _, client in ipairs(clients) do
		msg = msg .. client.name .. " "
	end
	vim.notify(msg, vim.log.levels.INFO, { title = "LSP Status" })
end, vim.tbl_extend("force", lsp_opts, { desc = "Show LSP status" }))

-- Restart LSP for current buffer
vim.keymap.set("n", "<leader>lr", function()
	vim.cmd("e") -- reload buffer
	vim.notify("Buffer reloaded, LSP should restart", vim.log.levels.INFO)
end, vim.tbl_extend("force", lsp_opts, { desc = "Reload buffer / LSP restart" }))
