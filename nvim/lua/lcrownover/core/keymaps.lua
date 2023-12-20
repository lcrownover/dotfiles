local bind = vim.keymap.set

-- centering screen on next find results
bind("n", "n", "nzzzv")
bind("n", "N", "Nzzzv")

-- better joining
bind("n", "J", "mzJ`z")

-- delete single character without copying into register
bind("n", "x", '"_x')

-- splits
bind("n", "<c-w>-", ":split<cr>", { silent = true, desc = "Horizontal split" })
bind("n", "<c-w>\\", ":vsplit<cr>", { silent = true, desc = "Vertical split" })
bind("n", "<c-w>w", ":close<cr>", { silent = true, desc = "Close split" })

-- toggle showing of whitespace characters
bind(
  "n",
  "<leader>sw",
  ":lua ToggleWhitespaceVisibility()<CR>",
  { silent = true, desc = "Toggle whitespace visibility" }
)

-- close the quickfix window
bind("n", "<leader>cf", ":copen<cr>", { silent = true, desc = "Open quickfix window" })
bind("n", "<leader>cc", ":cclose<cr>", { silent = true, desc = "Close quickfix window" })

-- scratch buffers, normal or splits
bind("n", "<leader>nn", ":enew<cr>", { silent = true, desc = "New scratch buffer" })
bind("n", "<leader>nv", ":vnew<cr>", { silent = true, desc = "New scratch buffer (vertical)" })
bind("n", "<leader>nh", ":new<cr>", { silent = true, desc = "New scratch buffer (horizontal)" })

-- toggle sign column for copy-paste
bind("n", "<leader>nu", ":set invnu<cr>:set invrnu<cr>", { silent = true, desc = "Toggle line numbers" })

-- close buffer
bind("n", "<leader>w", ":bd<cr>", { silent = true })

-- keep visual mode after indenting
bind("x", ">", ">gv")
bind("x", "<", "<gv")

-- quick key for regex
bind("n", "<leader>r", ":%s/", { silent = true, desc = "Search and replace entire buffer" })
bind("x", "<leader>r", ":s/", { silent = true, desc = "Search and replace selection" })

-- break undo sequence after punctuation
bind("i", ",", ",<c-g>u")
bind("i", ".", ".<c-g>u")
bind("i", "!", "!<c-g>u")
bind("i", "?", "?<c-g>u")

-- execute the current buffer with bash
-- bind("n", "<leader>xb", ":w !bash<cr>")

-- execute current file
-- bind("n", "<leader>xf", ":!%:p<cr>")

-- git
-- bind("n", "<leader>gg", ":terminal lazygit<cr>i")

-- diffing files
-- bind('n', '<leader>d<', ':diffthis<cr>')
-- bind('n', '<leader>d>', ':vsplit<cr>:diffthis<cr>:wincmd p<cr>:bprev<cr>')
-- bind('n', '<leader>dq', ':diffoff<cr>')

-- telescope custom locations
-- bind('n', '<leader>fv', "<cmd>lua require('telescope.builtin').find_files { cwd = '~/.config/nvim', follow = true}<cr>", {silent = true})
-- bind('n', '<leader>fn', "<cmd>lua require('lcrown.telescope').grep_notes()<cr>", {silent = true})

-- go to the directory of the current buffer
-- bind('n', '<leader>c', ':cd %:p:h<cr>')
