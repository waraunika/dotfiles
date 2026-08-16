local keymap = vim.keymap.set
local render_md_keys = {
	{ "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", "Toggle Markdown render" },
	{ "<leader>mp", "<cmd>RenderMarkdown preview<CR>", "Preview Markdown (split)" },
	{ "<leader>mp", "<cmd>MarkdownPreview<CR>", "Preview Markdown (split)" },
}
for _, key in ipairs(render_md_keys) do
	keymap("n", key[1], key[2], { desc = key[3], buffer = nil, silent = true })
end
