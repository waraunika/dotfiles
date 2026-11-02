-- lua/plugins/image.lua
return {
	"3rd/image.nvim",
	ft = { "markdown", "tex" },
	opts = {
		backend = "kitty",
		processor = "magick_cli", -- needs `magick` (ImageMagick) on PATH

		integrations = {
			markdown = {
				enabled = true,
				filetypes = { "markdown" },
				only_render_image_at_cursor = true,
				only_render_image_at_cursor_mode = "popup",
				resolve_image_path = function(document_path, image_path, fallback)
					return fallback(document_path, image_path)
				end,
			},
			-- image.nvim has no built-in tex integration, so we disable
			-- neorg/html/css defaults and drive tex previews manually below
			neorg = { enabled = false },
			html = { enabled = false },
			css = { enabled = false },
		},

		max_width = nil,
		max_height = nil,
		max_width_window_percentage = 80,
		max_height_window_percentage = 60,
		window_overlap_clear_enabled = true,
		editor_only_render_when_focused = true,
	},
	config = function(_, opts)
		require("image").setup(opts)

		-- Shift+P: toggle popup image preview under cursor (markdown links,
		-- or a \includegraphics{} path in tex — handled manually below)
		vim.keymap.set("n", "<S-p>", function()
			local ft = vim.bo.filetype

			if ft == "markdown" then
				-- image.nvim's cursor-popup mode handles this automatically when
				-- only_render_image_at_cursor = true; this just nudges a redraw
				-- so it reliably fires without moving the cursor first.
				vim.cmd("normal! ll")
				vim.cmd("normal! hh")
				return
			end

			if ft == "tex" then
				local line = vim.api.nvim_get_current_line()
				local path = line:match("\\includegraphics%s*%[?.-%]?{(.-)}")
				if not path then
					vim.notify("No \\includegraphics{} on this line", vim.log.levels.WARN)
					return
				end

				-- resolve relative to file dir, try common LaTeX image extensions
				local dir = vim.fn.expand("%:p:h")
				local candidates = { path }
				if not path:match("%.%a+$") then
					for _, ext in ipairs({ ".png", ".jpg", ".jpeg", ".pdf" }) do
						table.insert(candidates, path .. ext)
					end
				end

				local full
				for _, c in ipairs(candidates) do
					local p = dir .. "/" .. c
					if vim.fn.filereadable(p) == 1 then
						full = p
						break
					end
				end

				if not full then
					vim.notify("Image not found: " .. path, vim.log.levels.ERROR)
					return
				end

				local api = require("image")
				if vim.b._img_preview then
					vim.b._img_preview:clear()
					vim.b._img_preview = nil
					return
				end

				vim.b._img_preview = api.from_file(full, {
					window = vim.api.nvim_get_current_win(),
					with_virtual_padding = true,
				})
				vim.b._img_preview:render()
			end
		end, { desc = "Preview image under cursor (md/tex)" })
	end,
}
