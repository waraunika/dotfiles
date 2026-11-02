return {
	"hat0uma/csvview.nvim",
	ft = { "csv", "tsv" },
	cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle", "CsvViewInfo" },
	opts = {
		parser = {
			comments = { "#", "//" },
		},
		view = {
			display_mode = "border", -- More intuitive table borders; change to "highlight" if you prefer highlighting
			header_lnum = true,
			sticky_header = { enabled = true },
		},
	},
	keys = {
		-- Toggle CSV view
		{ "<leader>ct", "<cmd>CsvViewToggle<cr>", desc = "Toggle CSV View" },
		-- Enable/disable separately (optional)
		{ "<leader>ce", "<cmd>CsvViewEnable<cr>", desc = "Enable CSV View" },
		{ "<leader>cd", "<cmd>CsvViewDisable<cr>", desc = "Disable CSV View" },
		-- View current buffer information
		{ "<leader>ci", "<cmd>CsvViewInfo<cr>", desc = "CSV View Info" },
	},
}
