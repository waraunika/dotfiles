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

			if bg_transparent then
				require("notify").setup({
					background_colour = "#2E3440",
				})

				vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { fg = "#000000" })
				vim.api.nvim_set_hl(0, "BufferLineSeparator", { fg = "#2e3440" })
				vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { bold = true, italic = false })
			else
				vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { fg = "#000000" })
				vim.api.nvim_set_hl(0, "BufferLineSeparator", { fg = colors.on_secondary_fixed })
				vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { fg = "#000000" })
				vim.api.nvim_set_hl(0, "BufferLineSeparator", { fg = "#2e3440" })
				vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { bold = true, italic = false })
			end

		end

		vim.keymap.set("n", "<leader>bg", toggle_transparency, { noremap = true, silent = false })
	end,
}
