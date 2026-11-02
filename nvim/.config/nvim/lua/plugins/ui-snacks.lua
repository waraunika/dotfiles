-- https://github.com/folke/snacks.nvim
---@module 'snacks'

-- stylua: ignore
local keymaps = {
	-- [P]ick
	{ "<leader>pf",				function() Snacks.picker.files() end,
		desc = "[P]ick [F]iles" },
	{ "<leader>pg",				function() Snacks.picker.grep() end,
		desc = "[P]ick [G]rep" },
	{ "<leader>pr",				function() Snacks.picker.recent() end,
		desc = "[P]ick [R]ecent files" },
	{ "<leader>pb",				function() Snacks.picker.buffers() end,
		desc = "[P]ick [B]uffers" },
	{ "<leader>ps",				function() Snacks.picker.lsp_symbols() end,
		desc = "[P]ick LSP [S]ymbols" },
	{ "<leader>p/",				function() Snacks.picker.grep_buffers() end,
		desc = "[P]ick grep open buffers" },

	-- [S]earch (from telescope)
	{ "<leader>sh",       function() Snacks.picker.help() end,
		desc = "[S]earch [H]elp" },
	{ "<leader>sk",       function() Snacks.picker.keymaps() end,
		desc = "[S]earch [K]eymaps" },
	{ "<leader>ss",       function() Snacks.picker.pickers() end,
		desc = "[S]earch [S]elect picker" },
	{ "<leader>sw",       function() Snacks.picker.grep_word() end,
		desc = "[S]earch [W]ord", mode = { "n", "x" } },
	{ "<leader>sd",       function() Snacks.picker.diagnostics() end,
		desc = "[S]earch [D]iagnostics" },
	{ "<leader>sr",       function() Snacks.picker.resume() end,
		desc = "[S]earch [R]esume" },
	{ "<leader><leader>", function() Snacks.picker.buffers() end,
		desc = "Find existing buffers" },
	{ "<leader>/",        function() Snacks.picker.lines() end,
		desc = "Fuzzy search in current buffer" },

	-- zen
	{ "<leader>z",        function() Snacks.zen() end,
		desc = "Toggle Zen Mode" },
	{ "<leader>Z",        function() Snacks.zen.zoom() end,
		desc = "Toggle Zoom" },

	-- buffers
	{ "<A-w>",            function() Snacks.bufdelete({ force = true }) end,
		desc = "Close buffer" },

	-- git
	{ "<leader>gs",       function() Snacks.picker.git_status() end,
		desc = "Git status" },
	{ "<leader>gg",       function() Snacks.lazygit() end,
		desc = "Lazygit" },

	-- notifications
	{ "<leader>nd",       function() Snacks.notifier.hide() end,
		desc = "Dismiss notifications" },
	{ "<leader>nh",       function() Snacks.picker.notifications() end,
		desc = "Notification history" },

	-- lsp file rename
	{ "<leader>cR",       function() Snacks.rename.rename_file() end,
		desc = "Rename file" },

	-- terminal
	{ "<c-\\>",           function() Snacks.terminal() end,
		desc = "Toggle terminal" },
	{ "<leader>tf",       function() Snacks.terminal(nil, { win = { position = "float" } }) end,
		desc = "Terminal (float)" },
	{ "<leader>tv",       function() Snacks.terminal(nil, { win = { position = "right", width = 0.4 } }) end,
		desc = "Terminal (vertical)" },
	{ "<leader>tb",       function() Snacks.terminal("cmake --build build") end,
		desc = "Run CMake build" },
}

local function shorten(path)
	local home = os.getenv("HOME") or ""
	if home ~= "" and path:sub(1, #home) == home then
		return "~" .. path:sub(#home + 1)
	end
	return path
end

local function find_project_root(dir)
	local d = dir
	for _ = 1, 8 do -- max 8 level of nesting for a directory
		if vim.fn.isdirectory(d .. "/.git") == 1 then
			return d
		end

		local parent = vim.fn.fnamemodify(d, ":h")
		if parent == d then
			break
		end

		d = parent
	end
	return dir
end

local function recent_projects(max)
	local seen, out = {}, {}
	for _, file in ipairs(vim.v.oldfiles or {}) do
		if vim.fn.filereadable(file) == 1 then
			local root = find_project_root(vim.fn.fnamemodify(file, ":p:h"))

			if not seen[root] then
				seen[root] = true
				out[#out + 1] = root
			end
		end

		if #out >= max then
			break
		end
	end

	return out
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,

	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			width = 70, -- per pane
			pane_gap = 10,
			preset = {
				keys = {
					{ icon = "󰈞 ", key = "f", desc = "Find Files", action = ":lua Snacks.picker.files()" },
					{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
					{ icon = "󰥨 ", key = "d", desc = "Open Directory", action = ":OpenDir" },
					{ icon = "󰮔 ", key = "s", desc = "Find Session", action = ":SessionSearch" },
					{ icon = " ", key = "S", desc = "Save Session", action = ":SessionSave" },
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })",
					},
					{ icon = "󰎔 ", key = "u", desc = "Update Plugins", action = ":Lazy update" },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					{ icon = " ", key = "l", desc = "Lazy", action = ":Lazy" },
				},
				header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
			},

			sections = {
				-- pane 1: normal config
				{
					section = "header",
				},
				{
					pane = 1,
					text = { { "My Shangri-La beneath the summer moon, Oh, I will return again", hl = "comment" } },
					align = "center",
					padding = 1,
				},
				{
					pane = 1,
					section = "keys",
					gap = 0,
					padding = 1,
				},

				-- pane 2
				{
					pane = 2,
					title = "Recent Projects",
					padding = 1,
				},
				function()
					local items = {}
					for i, root in ipairs(recent_projects(5)) do
						items[#items + 1] = {
							pane = 2,
							indent = 2,
							key = tostring(i),
							desc = shorten(root),
							-- cd fires DirChanged, so auto-session restores that project's session
							action = function()
								vim.cmd("cd " .. vim.fn.fnameescape(root))
								vim.cmd("edit .")
							end,
						}
					end
					if #items == 0 then
						items[1] = { pane = 2, indent = 2, text = { { "No recent projects yet", hl = "comment" } } }
					end
					items[#items].padding = 1
					return items
				end,
				{
					pane = 2,
					title = "Recent Files",
					section = "recent_files",
					limit = 5,
					indent = 2,
					padding = 1,
				},
				{
					pane = 2,
					title = "Git Status",
					section = "terminal",
					enabled = function()
						return Snacks.git.get_root() ~= nil
					end,
					cmd = "git status --short --branch --renames",
					height = 6,
					indent = 2,
					padding = 1,
				},

				{ section = "startup" },
			},
		},
		explorer = { enabled = false, trash = true },
		indent = { enabled = true, animate = { enabled = true } },
		input = { enabled = true },
		picker = {
			enabled = false,
			prompt = " ",
			focus = "input",
			auto_close = true,
			layout = {
				cycle = true,
				preset = function()
					return vim.o.columns >= 100 and "default" or "vertical"
				end,
			},
			sources = {
				files = {
					hidden = true,
					exclude = {
						"node_modules",
						".git",
						".venv",
					},
				},
				grep = {
					hidden = true,
					exclude = {
						"node_modules",
						".git",
						".venv",
					},
				},
				explorer = {
					layout = {
						layout = {
							position = "right",
							width = 20,
							min_width = 10,
							max_width = 70,
						},
					},
					win = {
						list = {
							keys = {
								["<A-h>"] = { "<C-w>h", expr = true, mode = { "n", "i", "v" } },
								["<CR>"] = "confirm",
								["<2-LeftMouse>"] = "confirm",
								["l"] = "confirm",
								["<space>"] = "confirm",
								["<BS>"] = "explorer_up",
								["."] = "explorer_focus",
								["C"] = "explorer_close",
								["z"] = "explorer_close_all",
								["H"] = "toggle_hidden",
								["I"] = "toggle_ignored",

								["S"] = "edit_split",
								["s"] = "edit_vsplit",
								["t"] = "tab",

								["a"] = "explorer_add",
								["A"] = "explorer_add",
								["d"] = "explorer_del",
								["r"] = "explorer_rename",
								["c"] = "explorer_copy",
								["m"] = "explorer_move",
								["p"] = "explorer_paste",
								["y"] = { "explorer_yank", mode = { "n", "x" } },

								["P"] = "toggle_preview",
								["q"] = "cancel",
								["R"] = "explorer_update",
								["?"] = "toggle_help_list",
								["i"] = "inspect",

								["o"] = "explorer_open",

								["]g"] = "explorer_git_next",
								["[g"] = "explorer_git_prev",
								["]d"] = "explorer_diagnostic_next",
								["[d"] = "explorer_diagnostic_prev",
								["]w"] = "explorer_warn_next",
								["[w"] = "explorer_warn_prev",
								["]e"] = "explorer_error_next",
								["[e"] = "explorer_error_prev",

								["<c-c>"] = "tcd",
								["<leader>/"] = "picker_grep",
								["<c-t>"] = "terminal",
								["Z"] = "explorer_close_all",
							},
						},
					},
				},
			},
		},
		notifier = { enabled = true, timeout = 3000 },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		styles = {
			terminal = { backdrop = false },
			float = { backdrop = false },
		},
	},

	keys = keymaps,

	init = function()
		local function transparent()
			for _, group in ipairs({ "SnacksNormal", "SnacksNormalNC" }) do
				vim.api.nvim_set_hl(0, group, { bg = "NONE" })
			end
		end

		vim.api.nvim_create_autocmd("ColorScheme", { callback = transparent })
		vim.api.nvim_create_autocmd("User", { pattern = "VeryLazy", once = true, callback = transparent })
	end,
}
