-- https://github.com/olimorris/onedarkpro.nvim
return {
	"olimorris/onedarkpro.nvim",
	priority = 1000, -- Ensure it loads first
	config = function()
		require("onedarkpro").setup({
			options = {
				transparency = true,
			},
		})
		vim.cmd.colorscheme("onedark")

		vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#FFFFFF", bg = "#282e37", bold = true })
		vim.api.nvim_set_hl(0, "AlphaButtons", { link = "Function" })
		vim.api.nvim_set_hl(0, "AlphaShortcut", { link = "Keyword" })
		vim.api.nvim_set_hl(0, "AlphaFooter", { link = "Identifier" })

		local bg_transparent = false

		local toggle_transparency = function()
			bg_transparent = not bg_transparent
			require("onedarkpro").setup({
				options = {
					transparency = bg_transparent,
				},
			})
			vim.cmd.colorscheme("onedark")
		end

		vim.keymap.set("n", "<leader>bg", toggle_transparency, { noremap = true, silent = false })
	end,
}
