-- https://github.com/neovim/nvim-lspconfig

local ts_prefs = {
	suggest = { includeCompletionsForModuleExports = true },
	preferences = { includePackageJsonAutoImports = "auto" },
}

local servers = {
	-- pyright = {},
	-- ruff = {},
	-- eslint = {},
	-- cssls = {
	-- 	cmd = { "vscode-css-language-server", "--stdio" },
	-- },
	tailwindcss = {
		cmd = { "tailwindcss-language-server", "--stdio" },
		settings = {
			tailwindcss = {
				experminetal = {
					configFile = "src/app.css",
				},
			},
		},
	},
	jsonls = {
		cmd = { "vscode-json-language-server", "--stdio" },
	},
	lua_ls = {
		cmd = { vim.fn.expand("~/src/lua-language-server/bin/lua-language-server"), "--stdio" },
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				diagnostics = { globals = { "vim" } },
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
			},
		},
	},
	marksman = {},
	-- verible = {},
	svelte = {
		cmd = { "svelteserver", "--stdio" },
		settings = {
			svelte = {
				plugin = {
					typescript = {
						enable = true,
						completions = {
							enable = true,
						},
						diagnostics = {
							enable = true,
						},
					},
				},
			},
		},
	},

	ts_ls = {
		cmd = { "typescript-language-server", "--stdio" },
		init_options = {
			plugins = {
				{
					name = "typescript-svelte-plugin",
					location = "/usr/lib/node_modules/typescript-svelte-plugin/",
				},
			},
		},
		settings = {
			completions = { completeFunctionCalls = true },
			typescript = ts_prefs,
			javascript = ts_prefs,
		},
	},
	texlab = {
		settings = {
			texlab = {
				build = { onSave = false },
				forwardSearch = { executable = "" },
			},
		},
	},
	emmet_language_server = {
		filetypes = { "html", "css", "javascriptreact", "typescriptreact" },
	},
	clangd = {
		cmd = {
			"clangd",
			"--background-index",
			"--clang-tidy",
			"--completion-style=detailed",
			"--header-insertion=iwyu",
		},
	},
}

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
		},
		config = function()
			vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })

			local enabled, missing = {}, {}

			for name, cfg in pairs(servers) do
				vim.lsp.config(name, cfg)

				-- enabling only those servers that have binary installed
				local cmd = vim.lsp.config[name].cmd
				if type(cmd) == "table" and vim.fn.executable(cmd[1]) == 1 then
					table.insert(enabled, name)
				else
					table.insert(missing, name)
				end
			end

			vim.lsp.enable(enabled)

			if #missing > 0 then
				table.sort(missing)
				vim.api.nvim_create_autocmd("User", {
					pattern = "VeryLazy",
					once = true,
					callback = function()
						vim.notify("LSP binaries not found: " .. table.concat(missing, ", "), vim.log.levels.WARN)
					end,
				})
			end
		end,
	},
}
