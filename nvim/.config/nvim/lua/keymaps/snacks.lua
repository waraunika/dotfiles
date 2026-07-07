local keymap = vim.keymap.set


local snacks_keys = {
  { "<leader>pf", function() Snacks.picker.files() end, desc = "[P]ick [F]iles" },
  { "<leader>pg", function() Snacks.picker.grep() end,         desc = "[P]ick [G]rep" },
  { "<leader>pr", function() Snacks.picker.recent() end,       desc = "[P]ick [R]ecent files" },
  { "<leader>pb", function() Snacks.picker.buffers() end,      desc = "[P]ick [B]uffers" },
  { "<leader>ps", function() Snacks.picker.lsp_symbols() end,  desc = "[P]ick LSP [S]symbols" },
  { "<leader>p/", function() Snacks.picker.grep_buffers() end, desc = "[P]ick grep open buffers" }
}

for _, key in ipairs(snacks_keys) do
  keymap("n", key[1], key[2], { desc = key[3], buffer = nil, silent = true })
end