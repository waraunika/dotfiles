-- github.com/shaunsingh/nord.nvim 
local colors = require("colors")
return {
	"shaunsingh/nord.nvim",
	priority = 1000, -- Ensure it loads first
	config = function()
		vim.g.nord_disable_background = true
	
		require("nord").set()

		vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#FFFFFF", bg = "#282e37", bold = true })
		vim.api.nvim_set_hl(0, "AlphaButtons", { link = "Function" })
		vim.api.nvim_set_hl(0, "AlphaShortcut", { link = "Keyword" })
		vim.api.nvim_set_hl(0, "AlphaFooter", { link = "Identifier" })

		require("headlines").setup({
			markdown = {
				headline_highlights = {
					"Headline1",
					"Headline2",
					"Headline3",
					"Headline4",
					"Headline5",
					"Headline6",
				},
				codeblock_highlight = "CodeBlock",
				dash_highlight = "Dash",
				quote_highlight = "Quote"
			}
		})

		
		require("notify").setup({
			background_colour = "#2E3440",
		})

		require("nord").set()

		local bg_transparent = true

		local toggle_transparency = function()
			bg_transparent = not bg_transparent
			vim.g.nord_disable_background = bg_transparent
			require("nord").set()

			require("bufferline").setup({
				options = {
					separator_style = "slant",
					style = "none"
				},
				highlights = {
					separator = {
						fg = "#2e3440",
					},
					separator_selected = {
						fg = "#2e3440",
					},
					buffer_selected = {
						bold = true,
						italic = false,
						fg = colors.on_primary_container
					},
				}
			})

			require("notify").setup({
				background_colour = "#2E3440",
			})
		end

		vim.keymap.set("n", "<leader>bg", toggle_transparency, { noremap = true, silent = false })
	end,
}
