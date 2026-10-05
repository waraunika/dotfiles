local vars = require("vars")
local transparency = vars.theme ~= "oasis"

return {
	"uhs-robert/oasis.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.o.background = "light"
		require("oasis").setup({
			style = "desert",
			dark_style = nil, -- Applies to primary style only: Overrides dark mode with another theme (e.g., "abyss")
			light_style = "desert", -- Applies to primary style only: Overrides light mode with another theme (e.g., "dune")
			light_intensity = 5, -- Light background intensity (1-5): 1=subtle, 5=saturated
			use_legacy_comments = true, -- For "desert" style only, uses the loud skyblue comment color from desert.vim for a more retro experience
			themed_syntax = true, -- Uses the theme's primary color for statements/keywords. Set to false for the classic yellow syntax from desert.vim for a more retro experience
			transparent = transparency,
		})

		require("notify").setup({
			background_colour = "#000000",
			merge_duplicates = true,
		})

		vim.keymap.set("n", "<leader>ub", require("oasis").toggle_transparency, { desc = "Toggle transparency" })
		vim.cmd.colorscheme("oasis")
	end,
}
