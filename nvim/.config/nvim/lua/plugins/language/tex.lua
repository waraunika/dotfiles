-- https://github.com/lervag/vimtex
return {
	{
		"lervag/vimtex",
		lazy = false,
		ft = { "tex", "latex" },
		init = function()
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_view_general_viewer = "zathura"
			vim.g.vimtex_view_general_options = "--synctex-forward @line: @col:@pdf @pdf"

			vim.g.vimtex_compiler_method = "latexmk"
			vim.g.vimtex_compiler_latexmk = {
				build_dir = "build",
				options = {
					"-pdf",
					"-interaction=nonstopmode",
					"-synctex=1",
				}
			}

			vim.g.vimtex_view_automatic = 1
			vim.g.vimtex_quickfix_mode = 2
		end,
	},
}
