local keymaps = {
	{ "n", "<leader>lc", ":VimtexCompile<CR>", "Compile LaTeX" },
	{ "n", "<leader>lv", ":VimtexView<CR>", "View PDF" },
	{ "n", "<leader>ll", ":VimtexClean<CR>", "Clean aux files" },
	{ "n", "<leader>lk", ":VimtexStop<CR>", "Stop compilation" },
	{ "n", "<leader>le", ":VimtexErrors<CR>", "Show errors" },
	{ "n", "<leader>lt", ":VimtexTocToggle<CR>", "Toggle Table of Contents" },
	{ "n", "<leader>li", ":VimtexInfo<CR>", "VimTeX Info" },

	{ "n", "<leader>lq", [[o$$\begin{equation}<CR>\end{equation}$$<Esc>O<Tab>]], "Math Equation Env" },
	{ "n", "<leader>la", [[o$$\begin{align}<CR>\end{align}$$<Esc>O<Tab>]], "Math Equation Env" },
	{ "v", "<leader>lm", [[c$<C-r>"$<Esc>]], "LaTeX Wrap in $...$" },
	{ "v", "<leader>lM", [[c$$<CR><C-r>"<CR>$$<Esc>]], "LaTeX Wrap in $$...$$" },
}

for i = 1, #keymaps do
	keymaps[i][5] = { "latex", "markdown" }
end

return keymaps
