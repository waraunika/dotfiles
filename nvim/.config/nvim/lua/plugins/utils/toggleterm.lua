-- lua/plugins/utils/toggleterm.lua

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = {
		{ "<c-\\>", desc = "Toggle terminal (horizontal)" },
		{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal (float)" },
		{ "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Terminal (vertical)" },

		-- Compile + run the current C/C++ file with clang++, in a float terminal.
		-- Works on the file open in the CURRENT buffer -- no project/CMake needed.
		{
			"<leader>rr",
			function()
				-- %:p         = full path of current file, e.g. /home/you/practice/main.cpp
				-- %:p:h       = just the directory part (the "head"), drops the filename
				-- %:t:r       = just the filename, extension stripped (the "root"), e.g. "main"
				local file = vim.fn.expand("%:p")
				local dir = vim.fn.expand("%:p:h")
				local name = vim.fn.expand("%:t:r")

				-- pick clang++ for .cpp, clang for .c, based on the file's extension
				local ext = vim.fn.expand("%:e")
				local compiler = (ext == "c") and "clang" or "clang++"

				local std_flag = (ext == "c") and "-std=c17" or "-std=c++20"

				local compile_cmd = string.format(
					"%s %s -Wall -Wextra -g -o %s/%s %s && %s/%s",
					compiler,
					std_flag,
					dir,
					name,
					file,
					dir,
					name
				)

				local Terminal = require("toggleterm.terminal").Terminal
				local run_term = Terminal:new({
					cmd = compile_cmd,
					direction = "float",
					close_on_exit = false, -- stay open so you can read output/errors
				})
				run_term:toggle()
			end,
			desc = "Compile & run current C/C++ file",
		},

		{
			"<leader>tb",
			function()
				local Terminal = require("toggleterm.terminal").Terminal
				local build_term = Terminal:new({
					cmd = "cmake --build build",
					direction = "horizontal",
					close_on_exit = false,
				})
				build_term:toggle()
			end,
			desc = "Run CMake build",
		},
	},
	opts = {
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
		open_mapping = [[<c-\>]],
		direction = "horizontal",
		shading_factor = 2,
		float_opts = {
			border = "curved",
		},
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		local function set_terminal_keymaps()
			local map_opts = { buffer = 0 }
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], map_opts)
			vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], map_opts)
			vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], map_opts)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], map_opts)
			vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], map_opts)
			vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], map_opts)
		end

		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "term://*toggleterm#*",
			callback = set_terminal_keymaps,
		})
	end,
}
