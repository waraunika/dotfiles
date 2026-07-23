-- lua/plugins/window/greeter.lua (keep your image but update layout)
return {
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			-- Your image function (unchanged)
			local function get_image_header(path)
				local cmd = "ascii-image-converter " .. path .. " -b --width 100"
				local handle = io.popen(cmd)
				local result = handle:read("*a")
				handle:close()
				return vim.split(result, "\n")
			end

			local image_path = os.getenv("HOME") .. "/.config/nvim/images/png.png"

			dashboard.section.header.val = get_image_header(image_path)
			dashboard.section.header.opts.hl = "Statement"

			-- Your buttons (keep as-is)
			dashboard.section.buttons.val = {
				dashboard.button("f", "󰈞  Find Files", "<cmd>Telescope find_files<CR>"),
				dashboard.button("r", "  Recent Files", "<cmd>Telescope oldfiles<CR>"),
				dashboard.button("c", "  Config", "<cmd>Telescope find_files cwd=~/.config/nvim<CR>"),
				dashboard.button("u", "󰣿 Update", "<cmd>Lazy update<CR>"),
				dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
			}

			-- Custom message (your quote)
			local message = {
				type = "text",
				val = "My Shangri-La beneath the summer moon, Oh, I will return again",
				opts = { hl = "comment", position = "center" },
			}

			-- Layout with your message
			dashboard.config.layout = {
				{ type = "padding", val = 2 },
				dashboard.section.header,
				{ type = "padding", val = 2 },
				message,
				{ type = "padding", val = 2 },
				dashboard.section.buttons,
				dashboard.section.footer,
			}

			alpha.setup(dashboard.opts)
		end,
	},
}

