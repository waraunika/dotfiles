-- https://github.com/neanias/everforest-nvim-

return {
	"sainnhe/everforest",
	lazy = false,
	priority = 1000,
	config = function()
		-- Optionally configure and load the colorscheme
		-- directly inside the plugin declaration.
		vim.g.everforest_enable_italic = true
		vim.g.everforest_transparent_background = 2
		vim.cmd.colorscheme("everforest")

		local bg_transparent = true

		local toggle_transparency = function()
			bg_transparent = not bg_transparent

			if bg_transparent then
				vim.g.everforest_transparent_background = 2
				vim.cmd.colorscheme("everforest")
			else
				vim.g.everforest_transparent_background = 0
				vim.cmd.colorscheme("everforest")
			end
		end

		vim.keymap.set("n", "<leader>bg", toggle_transparency, { noremap = true, silent = false })
	end,
}
