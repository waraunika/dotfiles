local cmd = vim.api.nvim_create_autocmd
local diagnostic = vim.diagnostic.config

cmd("FileType", {
	pattern = "markdown",
	callback = function(args)
		vim.keymap.set("i", "*", function()
			local line = vim.api.nvim_get_current_line()
			local col = vim.api.nvim_win_get_cursor(0)[2]

			local char_before = line:sub(col, col)
			local char_after = line:sub(col + 1, col + 1)

			if char_before == "*" and char_after == "*" then
				return "**<Left>"
			end

			if char_before == "*" then
				return "*<Right>**<Left><Left>"
			end

			if char_after == "*" then
				return "<Right>"
			end

			return "**<Left>"
		end, {
			expr = true,
			buffer = args.buf,
			silent = true,
			desc = "Set * to ** and ** to ****",
		})
	end,
})

cmd("BufWritePost", {
	pattern = { "*.ipynb" },
	callback = function()
		if require("molten.status").initialized() == "Molten" then
			vim.cmd("MoltenExportOutput!")
		end
	end,
})

diagnostic({
	jump = {
		on_jump = function()
			vim.diagnostic.open_float()
		end,
	},
})
