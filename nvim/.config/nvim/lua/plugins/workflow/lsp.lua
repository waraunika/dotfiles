return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		opts = {},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"ts_ls",
				"eslint",
				"cssls",
				"tailwindcss",
				"jsonls",
				"lua_ls",
				"texlab",
				"marksman",
			}
		},
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp"
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local servers = {
				"ts_ls",
				"eslint",
				"cssls",
				"tailwindcss",
				"jsonls",
				"lua_ls",
				"texlab",
				"marksman"
			}

			for _, server in ipairs(servers) do
				vim.lsp.config(server, { capabilities = capabilities })
			end
			vim.lsp.enable(servers)

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local opts = { buffer = args.buf }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				end
			})
		end
	}
}
