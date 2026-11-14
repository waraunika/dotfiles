-- https://github.com/stevearc/conform.nvim
local prettier = { "prettierd", "prettier", stop_after_first = true }

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},

	opts = {
		formatters_by_ft = {
			c = { "clang-format" },
			cpp = { "clang-format" },
			python = { "isort", "black" },
			javascript = prettier,
			javascriptreact = prettier,
			typescript = prettier,
			typescriptreact = prettier,
			css = prettier,
			html = prettier,
			json = prettier,
			sh = { "shfmt" },
			verilog = { "verible_verilog_format" },
			systemverilog = { "verible_verilog_format" },
			sql = { "pg_format" },
			lua = { "stylua" },
		},

		default_format_opts = {
			lsp_format = "fallback",
		},

		format_on_save = {
			timeout_ms = 2000,
		},

		formatters = {
			shfmt = {
				append_args = { "-i", "2" },
			},
			pg_format = {
				append_args = { "-w", "90", "--vertical-align", "-g", "-k" },
			},
			stylua = {
				command = "/home/death/src/stylua",
			},
		},
	},

	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
