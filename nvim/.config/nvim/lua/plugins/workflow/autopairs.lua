-- https://github.com/windwp/nvim-autopairs
return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	dependencies = { "saghen/blink.cmp" },
	opts = {
		check_ts = true, -- respect treesitter (e.g. don't pair inside strings)
	},
}
