return {
	"HakonHarnes/img-clip.nvim",
	event = "VeryLazy",
	opts = {
		default = {
			dir_path = "attachmnets",
			relative_to_current_file = true,
			use_absolute_path = false,
			file_name = "%Y-%m-%d-%H-%M-%S",
			extension = "png"
		}
	},

	keys = {
		{ "<leader>pi", "<cmd>PasteImage<cr>", desc = "[P]aste [I]mage from clipboard" }
	}
}
