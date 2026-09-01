-- NEEDS FIXING
-- Jupyter notebooks in Neovim: molten (kernel execution) + jupytext (.ipynb <-> .py conversion)
-- https://github.com/benlubas/molten-nvim
-- https://github.com/GCBallesteros/jupytext.nvim
return {
	{
		"benlubas/molten-nvim",
		version = "^1.0.0", -- pin to major version; breaking changes happen across majors
		build = ":UpdateRemotePlugins",
		dependencies = { "3rd/image.nvim" }, -- you already have this for plot/image output
		cmd = {
			"MoltenInit",
			"MoltenEvaluateOperator",
			"MoltenEvaluateLine",
			"MoltenReevaluateCell",
			"MoltenDelete",
			"MoltenHideOutput",
			"MoltenEvaluateVisual",
		},
		init = function()
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 20
			vim.g.molten_auto_open_output = true
			vim.g.molten_wrap_output = true
			vim.g.molten_virt_text_output = true -- shows a small virtual text marker under executed cells
		end,
		keys = {
			{ "<leader>mi", "<cmd>MoltenInit<CR>", desc = "Initialize Molten kernel" },
			{ "<leader>me", "<cmd>MoltenEvaluateOperator<CR>", desc = "Evaluate operator" },
			{ "<leader>ml", "<cmd>MoltenEvaluateLine<CR>", desc = "Evaluate line" },
			{ "<leader>mc", "<cmd>MoltenReevaluateCell<CR>", desc = "Re-eval cell" },
			{ "<leader>md", "<cmd>MoltenDelete<CR>", desc = "Delete Molten cell" },
			{ "<leader>mh", "<cmd>MoltenHideOutput<CR>", desc = "Hide output" },
			{ "<leader>mv", ":<C-u>MoltenEvaluateVisual<CR>gv", mode = "v", desc = "Evaluate visual selection" },
		},
	},
	{
		"GCBallesteros/jupytext.nvim",
		ft = { "ipynb" },
		opts = {
			style = "markdown", -- or "percent" for `# %%` cell markers
			output_extension = "md",
			force_ft = "markdown",
		},
	},
}
