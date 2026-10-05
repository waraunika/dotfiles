return {
	"causality-enjoyer/image-cursor.nvim",
	ft = { "markdown" },
	config = function()
		require("image-cursor").setup({
			-- which filetypes to watch for image links in
			filetypes = { "markdown" },
			-- max preview size, unit: terminal cells
			max_width_cells = 70,
			max_height_cells = 20,
			-- min usable cell height
			min_height_cells = 6,
			-- ratio for cell width/height for your terminal, defaults to 0.5
			cell_aspect = nil,

			-- keymap to mannually toggle the preview for current line
			-- Set to false to disable
			keys = {
				toggle = "<leader>ii",
			},
		})
	end,
}
