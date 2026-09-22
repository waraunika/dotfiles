local keymaps = {
	{ "n", "gd", vim.lsp.buf.definition, "Go to definition" },
	{ "n", "gD", vim.lsp.buf.declaration, "Go to declaration" },
	{ "n", "gr", vim.lsp.buf.references, "Go to references" },
	{ "n", "gi", vim.lsp.buf.implementation, "Go to implementation" },

	{ "n", "K", vim.lsp.buf.hover, "Hover documentation" },
	{ "n", "<C-k>", vim.lsp.buf.signature_help, "Signature help" },

	{ "n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol" },
	{ "n", "<leader>ca", vim.lsp.buf.code_action, "Code action" },
	{
		"n",
		"<leader>dl",
		function()
			vim.diagnostic.open_float({ scope = "line" })
		end,
		"Line diagnostics",
	},
	{
		"n",
		"<leader>f",
		function()
			vim.lsp.buf.format({ async = true })
		end,
		"Format document",
	},
	{
		"n",
		"<leader>ls",
		function()
			local clients = vim.lsp.get_clients()
			local msg = "Active LSP clients: "
			for _, client in ipairs(clients) do
				msg = msg .. client.name .. " "
			end
			vim.notify(msg, vim.log.levels.INFO, { title = "LSP Status" })
		end,
		"Show LSP status",
	},
	{
		"n",
		"<leader>lr",
		function()
			vim.cmd("e")
			vim.notify("Reloaded buffer / LSP restarted", vim.log.levels.INFO)
		end,
		"Reload buffer / LSP restart",
	},
}

return keymaps
