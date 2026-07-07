local keymap = vim.keymap.set

local vimtex_keys_n = {
  { "<leader>lc", "<cmd>VimtexCompile<CR>", "Compile LaTeX" },
  { "<leader>lv", "<cmd>VimtexView<CR>", "View PDF" },
  { "<leader>ll", "<cmd>VimtexClean<CR>", "Clean aux files" },
  { "<leader>lk", "<cmd>VimtexStop<CR>", "Stop compilation" },
  { "<leader>le", "<cmd>VimtexErrors<CR>", "Show errors" },
  { "<leader>lt", "<cmd>VimtexTocToggle<CR>", "Toggle Table of Contents" },
  { "<leader>li", "<cmd>VimtexInfo<CR>", "VimTeX Info" },
}

local vimtex_keys_v = {
  { "<leader>lm", [[c$<C-r>"$<Esc>]], "LaTeX Wrap in $...$" },
  { "<leader>lM", [[c$$<CR><C-r>"<CR>$$<Esc>]], "LaTeX Wrap in $...$" }
}

for _, key in ipairs(vimtex_keys_n) do
  keymap("n", key[1], key[2], { desc = key[3], buffer = nil, silent = true })
end

for _, key in ipairs(vimtex_keys_n) do
  keymap("v", key[1], key[2], { desc = key[3], buffer = nil, silent = true })
end