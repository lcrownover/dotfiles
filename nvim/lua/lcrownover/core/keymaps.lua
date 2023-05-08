local bind = vim.keymap.set

-- centering screen on next find results
bind("n", "n", "nzzzv")
bind("n", "N", "Nzzzv")

-- better joining
bind("n", "J", "mzJ`z")

-- delete single character without copying into register
bind("n", "x", '"_x')

-- splits
bind("n", "<leader>s-", ":split<cr>", { silent = true })
bind("n", "<leader>s\\", ":vsplit<cr>", { silent = true })
bind("n", "<leader>sc", ":close<cr>", { silent = true })

-- toggle showing of whitespace characters
bind("n", "<leader>sw", ":lua ToggleWhitespaceVisibility()<CR>")

-- close the quickfix window
bind("n", "<leader>c", ":cclose<cr>", { silent = true })

-- scratch buffers, normal or splits
bind("n", "<leader>nn", ":enew<cr>")
bind("n", "<leader>nv", ":vnew<cr>")
bind("n", "<leader>nh", ":new<cr>")

-- toggle sign column for copy-paste
bind("n", "<leader>nu", ":set invnu<cr>:set invrnu<cr>")

-- close buffer
bind("n", "<leader>w", ":bd<cr>", { silent = true })

-- keep visual mode after indenting
bind("x", ">", ">gv")
bind("x", "<", "<gv")

-- quick key for regex
bind("n", "<leader>r", ":%s/")
bind("x", "<leader>r", ":s/")

-- execute the current buffer with bash
bind("n", "<leader>xb", ":w !bash<cr>")

-- execute current file
bind("n", "<leader>xf", ":!%:p<cr>")

-- break undo sequence after punctuation
bind("i", ",", ",<c-g>u")
bind("i", ".", ".<c-g>u")
bind("i", "!", "!<c-g>u")
bind("i", "?", "?<c-g>u")

-- git
bind("n", "<leader>gg", ":terminal lazygit<cr>i")

-- diffing files
-- bind('n', '<leader>d<', ':diffthis<cr>')
-- bind('n', '<leader>d>', ':vsplit<cr>:diffthis<cr>:wincmd p<cr>:bprev<cr>')
-- bind('n', '<leader>dq', ':diffoff<cr>')

-- telescope custom locations
-- bind('n', '<leader>fv', "<cmd>lua require('telescope.builtin').find_files { cwd = '~/.config/nvim', follow = true}<cr>", {silent = true})
-- bind('n', '<leader>fn', "<cmd>lua require('lcrown.telescope').grep_notes()<cr>", {silent = true})

-- go to the directory of the current buffer
-- bind('n', '<leader>c', ':cd %:p:h<cr>')
