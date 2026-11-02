-- Plugins: Vimtex for compiling, TeXpresso for live preview
return {
	-- https://github.com/lervag/vimtex
	{
		"lervag/vimtex",
		lazy = false,
		ft = { "tex", "latex" },
		init = function()
			vim.g.vimtex_view_method = "general"
			vim.g.vimtex_view_general_viewer = "sioyek"
			vim.g.vimtex_view_general_options = "--new-instance --reuse-window "
				.. '--inverse-search "nvim --headless -c \'VimtexInverseSearch %2 \\"%1\\"\'" '
				.. "--forward-search-file @tex --forward-search-line @line @pdf"

			vim.g.vimtex_compiler_method = "latexmk"
			vim.g.vimtex_compiler_latexmk = {
				out_dir = "build",
				options = {
					"-pdf",
					"-interaction=nonstopmode",
					"-synctex=1",
					"-outdir=build",
				},
			}

			vim.g.vimtex_view_automatic = 1
			vim.g.vimtex_quickfix_mode = 2
		end,
	},

	-- https://github.com/let-def/texpresso.vim
	{
		"let-def/texpresso.vim",
		ft = { "tex", "latex" },
		config = function()
			local texpresso = require("texpresso")
			texpresso.texpresso_path = vim.fn.expand("~/src/texpresso/build/texpresso")
			texpresso.texpresso_xetex_path = vim.fn.expand("~/src/texpresso/build/texpresso-xetex")
		end,
		keys = {
			{
				"<leader>lx",
				function()
					vim.cmd("TeXpresso " .. vim.fn.expand("%:p"))
				end,
				ft = { "tex", "latex" },
				desc = "Start TeXpresso live preview",
			},
		},
	},
}
