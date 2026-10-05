local cmd = vim.api.nvim_create_autocmd
local diagnostic = vim.diagnostic.config
local user_cmd = vim.api.nvim_create_user_command

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

local function open_dir()
	vim.ui.input({ prompt = "Directory (relative to ~): " }, function(input)
		if not input or input == "" then
			return
		end

		local path = vim.fn.expand("~/" .. input)

		if vim.fn.isdirectory(path) == 0 then
			vim.notify("Not a directory: " .. path, vim.log.levels.ERROR)
			return
		end

		vim.cmd("cd " .. vim.fn.fnameescape(path))
		vim.cmd("e.")
	end)
end
user_cmd("OpenDir", open_dir, {})

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
