return {
	"saghen/blink.cmp",
	version = "1.*",
	opts = {
		keymap = {
			preset = "none",

			["<Tab>"] = { "select_and_accept", "fallback" }, -- accept immediately, even without prior selection
			["<S-Tab>"] = { "select_prev", "fallback" },

			["<C-n>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },

			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },

			["<CR>"] = { "accept", "fallback" }, -- Enter accepts if menu is open, else normal Enter
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
}
