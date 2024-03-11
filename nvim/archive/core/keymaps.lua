-- centering screen on next find results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- better joining
vim.keymap.set("n", "J", "mzJ`z")

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x')

-- splits
vim.keymap.set("n", "<c-w>-", ":split<cr>", { silent = true, desc = "Horizontal split" })
vim.keymap.set("n", "<c-w>\\", ":vsplit<cr>", { silent = true, desc = "Vertical split" })
vim.keymap.set("n", "<c-w>w", ":close<cr>", { silent = true, desc = "Close split" })

-- toggle showing of whitespace characters
vim.keymap.set(
  "n",
  "<leader>sw",
  ":lua ToggleWhitespaceVisibility()<CR>",
  { silent = true, desc = "Toggle whitespace visibility" }
)

-- close the quickfix window
vim.keymap.set("n", "<leader>cf", ":copen<cr>", { silent = true, desc = "Open quickfix window" })
vim.keymap.set("n", "<leader>cc", ":cclose<cr>", { silent = true, desc = "Close quickfix window" })

-- scratch buffers, normal or splits
vim.keymap.set("n", "<leader>nn", ":enew<cr>", { silent = true, desc = "New scratch buffer" })
vim.keymap.set("n", "<leader>nv", ":vnew<cr>", { silent = true, desc = "New scratch buffer (vertical)" })
vim.keymap.set("n", "<leader>nh", ":new<cr>", { silent = true, desc = "New scratch buffer (horizontal)" })

-- toggle sign column for copy-paste
vim.keymap.set("n", "<leader>nu", ":set invnu<cr>:set invrnu<cr>", { silent = true, desc = "Toggle line numbers" })

-- close buffer
vim.keymap.set("n", "<leader>w", ":bd<cr>", { silent = true })

-- keep visual mode after indenting
vim.keymap.set("x", ">", ">gv")
vim.keymap.set("x", "<", "<gv")

-- quick key for regex
vim.keymap.set("n", "<leader>r", ":%s/", { silent = true, desc = "Search and replace entire buffer" })
vim.keymap.set("x", "<leader>r", ":s/", { silent = true, desc = "Search and replace selection" })

-- break undo sequence after punctuation
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", "!", "!<c-g>u")
vim.keymap.set("i", "?", "?<c-g>u")

-- execute the current buffer with bash
-- vim.keymap.set("n", "<leader>xb", ":w !bash<cr>")

-- execute current file
-- vim.keymap.set("n", "<leader>xf", ":!%:p<cr>")

-- git
-- vim.keymap.set("n", "<leader>gg", ":terminal lazygit<cr>i")

-- diffing files
-- vim.keymap.set('n', '<leader>d<', ':diffthis<cr>')
-- vim.keymap.set('n', '<leader>d>', ':vsplit<cr>:diffthis<cr>:wincmd p<cr>:bprev<cr>')
-- vim.keymap.set('n', '<leader>dq', ':diffoff<cr>')

-- telescope custom locations
-- vim.keymap.set('n', '<leader>fv', "<cmd>lua require('telescope.builtin').find_files { cwd = '~/.config/nvim', follow = true}<cr>", {silent = true})
-- vim.keymap.set('n', '<leader>fn', "<cmd>lua require('lcrown.telescope').grep_notes()<cr>", {silent = true})

-- go to the directory of the current buffer
-- vim.keymap.set('n', '<leader>c', ':cd %:p:h<cr>')
