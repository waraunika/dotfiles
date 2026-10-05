return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- ASCII-art header from wallpaper/logo image
		local function get_image_header(path)
			local cmd = "ascii-image-converter " .. path .. " -b --width 100"
			local handle = io.popen(cmd)
			if not handle then
				return { "" }
			end
			local result = handle:read("*a")
			handle:close()
			return vim.split(result, "\n")
		end

		local image_path = os.getenv("HOME") .. "/.config/nvim/images/png.png"
		dashboard.section.header.val = get_image_header(image_path)
		dashboard.section.header.opts.hl = "Statement"

		-- ---------------------------------------------------------------
		-- Recent projects: derived from :oldfiles, deduplicated down to
		-- each file's containing directory (walking up to the nearest
		-- .git root when one exists, otherwise the file's own directory).
		-- This needs no auto-session internals -- :oldfiles is core Neovim.
		-- ---------------------------------------------------------------
		local function find_project_root(file_dir)
			local dir = file_dir
			for _ = 1, 8 do -- don't walk up forever
				if vim.fn.isdirectory(dir .. "/.git") == 1 then
					return dir
				end
				local parent = vim.fn.fnamemodify(dir, ":h")
				if parent == dir then
					break
				end
				dir = parent
			end
			return file_dir
		end

		local function recent_projects(max_count)
			local seen, projects = {}, {}
			for _, file in ipairs(vim.v.oldfiles or {}) do
				if vim.fn.filereadable(file) == 1 then
					local root = find_project_root(vim.fn.fnamemodify(file, ":p:h"))
					if not seen[root] then
						seen[root] = true
						table.insert(projects, root)
					end
				end
				if #projects >= max_count then
					break
				end
			end
			return projects
		end

		local function shorten(path)
			local home = os.getenv("HOME") or ""
			if home ~= "" and path:sub(1, #home) == home then
				return "~" .. path:sub(#home + 1)
			end
			return path
		end

		local project_buttons = {}
		for i, root in ipairs(recent_projects(5)) do
			local label = shorten(root)
			table.insert(
				project_buttons,
				dashboard.button(
					tostring(i),
					"  " .. label,
					-- cd into the project root; auto-session's DirChanged
					-- handling (see plugins/workflow/session.lua) then
					-- restores that project's session automatically.
					"<cmd>cd " .. vim.fn.fnameescape(root) .. " | e.<CR>"
				)
			)
		end
		if #project_buttons == 0 then
			project_buttons = {
				{ type = "text", val = "  No recent projects yet", opts = { hl = "comment", position = "center" } },
			}
		end

		-- ---------------------------------------------------------------
		-- Buttons
		-- ---------------------------------------------------------------
		dashboard.section.buttons.val = {
			dashboard.button("f", "󰈞  Find Files", "<cmd>lua Snacks.picker.files()<CR>"),
			dashboard.button("r", "  Recent Files", "<cmd>lua Snacks.picker.recent()<CR>"),
			dashboard.button("d", "󰥨  Open Directory", "<cmd>OpenDir<CR>"),
			dashboard.button("s", "󰮔  Find Session", "<cmd>SessionSearch<CR>"),
			dashboard.button("S", "  Save Session", "<cmd>SessionSave<CR>"),
			dashboard.button("c", "  Config", "<cmd>lua Snacks.picker.files({cwd = vim.fn.stdpath('config')})<CR>"),
			dashboard.button("u", "󰎔  Update Plugins", "<cmd>Lazy update<CR>"),
			dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
		}
		dashboard.section.buttons.opts = { spacing = 0 }

		local projects_section = {
			type = "group",
			val = {
				{ type = "text", val = "Recent Projects", opts = { hl = "SpecialComment", position = "center" } },
				{ type = "padding", val = 1 },
				{ type = "group", val = project_buttons, opts = { spacing = 0 } },
			},
		}

		local message = {
			type = "text",
			val = "My Shangri-La beneath the summer moon, Oh, I will return again",
			opts = { hl = "comment", position = "center" },
		}

		dashboard.config.layout = {
			{ type = "padding", val = 0 },
			dashboard.section.header,
			{ type = "padding", val = 0 },
			message,
			{ type = "padding", val = 2 },
			projects_section,
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			{ type = "padding", val = 0 },
			dashboard.section.footer,
		}

		-- Footer: plugin count + startup time, standard alpha recipe.
		alpha.setup(dashboard.opts)

		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyDone",
			once = true,
			callback = function()
				local stats = require("lazy").stats()
				local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
				dashboard.section.footer.val = "⚡ "
					.. stats.loaded
					.. "/"
					.. stats.count
					.. " plugins loaded in "
					.. ms
					.. "ms"
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end,
}
