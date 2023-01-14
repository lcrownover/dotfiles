-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

map("n", "<leader>u", ":UndotreeShow<CR>", { silent = true })

-- centering screen on next results
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- better joining
map("n", "J", "mzJ`z")

-- delete single character without copying into register
map("n", "x", '"_x')

-- splits
map("n", "<leader>s-", ":split<cr>", { silent = true })
map("n", "<leader>s\\", ":vsplit<cr>", { silent = true })
map("n", "<leader>sc", ":close<cr>", { silent = true })

-- toggle showing of whitespace characters
map("n", "<leader>sw", ":lua ToggleWhitespaceVisibility()<CR>")

-- execute the current buffer with bash
map("n", "<leader>xb", ":w !bash<cr>")

-- execute current file
map("n", "<leader>xf", ":!%:p<cr>")

-- close the quickfix window
map("n", "<leader>c", ":cclose<cr>", { silent = true })

-- scratch buffers, normal or splits
map("n", "<leader>nn", ":enew<cr>")
map("n", "<leader>nv", ":vnew<cr>")
map("n", "<leader>nh", ":new<cr>")

-- toggle sign column for copy-paste
map("n", "<leader>nu", ":set invnu<cr>:set invrnu<cr>")

-- close buffer
map("n", "<leader>w", ":close<cr>", { silent = true })

-- keep visual mode after indenting
map("x", ">", ">gv")
map("x", "<", "<gv")

-- quick key for regex
map("n", "<leader>r", ":%s/")
map("x", "<leader>r", ":s/")

-- diffing files
-- map('n', '<leader>d<', ':diffthis<cr>')
-- map('n', '<leader>d>', ':vsplit<cr>:diffthis<cr>:wincmd p<cr>:bprev<cr>')
-- map('n', '<leader>dq', ':diffoff<cr>')

-- bufferline
-- map('n', '<c-h>', ':BufferPrevious<cr>', {silent = true})
-- map('n', '<c-l>', ':BufferNext<cr>', {silent = true})

-- telescope custom locations
-- map('n', '<leader>fv', "<cmd>lua require('telescope.builtin').find_files { cwd = '~/.config/nvim', follow = true}<cr>", {silent = true})
-- map('n', '<leader>fn', "<cmd>lua require('lcrown.telescope').grep_notes()<cr>", {silent = true})

-- custom navigation
-- map('n', '<leader>p', "<cmd>lua require('telescope.builtin').find_files({follow = true})<cr>", {silent = true})
-- map('n', '<leader>f', "<cmd>lua require('telescope.builtin').live_grep()<cr>", {silent = true})
-- map('n', '<c-f>', "<cmd>lua require('telescope.builtin').live_grep()<cr>", {silent = true})
-- map('n', '<c-p>', "<cmd>lua require('telescope.builtin').find_files()<cr>", {silent = true})

-- FloaTerm configuration
-- map('n', "<leader>ft", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 zsh <CR> ")
-- map('n', "t", ":FloatermToggle myfloat<CR>")
-- vim.keymap.set('t', "<Esc>", "<C-\\><C-n>:q<CR>")

-- open a new nvim terminal
-- map('n', '<leader>t', ':terminal<cr>i')
-- map('t', '<esc>', '<c-\\><c-n>')
-- map('t', '<c-v><esc>', '<esc>')
--
-- open fancy split terminal
-- map('n', '<c-t>', ':lua toggle_terminal()<CR>', {silent = true})
-- map('i', '<c-t>', '<ESC>:lua toggle_terminal()<CR>', {silent = true})
-- map('t', '<c-t>', '<c-\\><c-n>:lua toggle_terminal()<CR>', {silent = true})

-- remaps to handle terminal usage and command execution
-- map('n', '<leader>xc', ':vnew <bar> :setlocal buftype=nofile <bar> r !<space>')

-- go to the directory of the current buffer
-- map('n', '<leader>c', ':cd %:p:h<cr>')
