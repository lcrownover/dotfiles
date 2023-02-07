local bind = vim.keymap.set

bind("n", "<leader>u", ":UndotreeShow<CR>", { silent = true })

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

-- eunuch
bind("n", "<leader>xm", ":Chmod +x<cr>")

-- nvim-tree
bind("n", "<C-b>", ":Neotree toggle<CR>", { silent = true })
bind("n", "<leader>b", ":Neotree filesystem reveal<CR>", { silent = true })

-- barbar
bind("n", "<C-n>", "<cmd>BufferNext<cr>")
bind("n", "<C-p>", "<cmd>BufferPrevious<cr>")

-- fugitive
bind("n", "<leader>gs", ":Git<cr>")
bind("n", "<leader>gc", ":Git commit<cr>")
bind("n", "<leader>gp", ":Git push<cr>")
bind("n", "<leader>gb", ":Git blame<cr>")
bind("n", "<leader>gd", ":Gvdiffsplit<cr>")
bind("n", "<leader>gh", ":diffget //2<cr>")
bind("n", "<leader>gl", ":diffget //3<cr>")

-- trouble
bind("n", "<leader>tt", ":Trouble<cr>", { silent = true })
bind("n", "<leader>tq", ":TroubleClose<cr>", { silent = true })
bind("n", "<leader>tr", ":TroubleRefresh<cr>", { silent = true })

-- telescope
bind("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files({follow = true})<cr>", { silent = true })
bind("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", { silent = true })
bind("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", { silent = true })
bind("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", { silent = true })
bind("n", "<leader>f;", "<cmd>lua require('telescope.builtin').resume()<cr>", { silent = true })
bind("n", "<leader>fq", "<cmd>lua require('telescope.builtin').quickfix()<cr>", { silent = true })
bind("n", "<leader>fk", "<cmd>lua require('telescope.builtin').keymaps()<cr>", { silent = true })
bind("n", "<leader>fc", "<cmd>lua require('telescope.builtin').git_commits()<cr>", { silent = true })
bind("n", "<leader>fs", "<cmd>lua require('telescope.builtin').git_status()<cr>", { silent = true })
bind("n", "<leader>fa", "<cmd>lua require('telescope.builtin').autocommands()<cr>", { silent = true })

-- lsp
bind("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>")
bind("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
bind("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>")
bind("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
bind("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
bind("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>")
bind("n", "<leader>fs", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>")
bind("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
bind("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
bind("n", "<leader>lr", ":LspRestart<cr>")
bind("n", "<leader>li", ":LspInfo<cr>")

-- lspsaga remaps
bind("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")
bind("n", "K", "<cmd>Lspsaga hover_doc<CR>")
bind("n", "gn", "<cmd>Lspsaga rename<CR>")
bind("n", "<F2>", "<cmd>Lspsaga rename<CR>")
bind("n", "gs", "<cmd>Lspsaga peek_definition<CR>")
-- jump diagnostic
bind("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
bind("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
-- or jump to error
bind("n", "[E", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
bind("n", "]E", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end)

-- dap
bind("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<cr>", { silent = true })
bind("n", "<leader>dc", ":lua require'dap'.continue()<cr>", { silent = true })
bind("n", "<leader>di", ":lua require'dap'.step_into()<cr>", { silent = true })
bind("n", "<leader>du", ":lua require'dap'.step_out()<cr>", { silent = true })
bind("n", "<leader>do", ":lua require'dap'.step_over()<cr>", { silent = true })
bind("n", "<leader>dg", ":lua require'dapui'.toggle()<cr>", { silent = true })
bind("n", "<F5>", ":lua require'dap'.continue()<CR>", { silent = true })
bind("n", "<F6>", ":lua require'dapui'.toggle()<CR>", { silent = true })
bind("n", "<F10>", ":lua require'dap'.step_over()<CR>", { silent = true })
bind("n", "<F11>", ":lua require'dap'.step_into()<CR>", { silent = true })
bind("n", "<F12>", ":lua require'dap'.step_out()<CR>", { silent = true })
bind("i", ",", ",<c-g>u")
bind("i", ".", ".<c-g>u")
bind("i", "!", "!<c-g>u")
bind("i", "?", "?<c-g>u")

-- diffing files
-- bind('n', '<leader>d<', ':diffthis<cr>')
-- bind('n', '<leader>d>', ':vsplit<cr>:diffthis<cr>:wincmd p<cr>:bprev<cr>')
-- bind('n', '<leader>dq', ':diffoff<cr>')

-- bufferline
-- bind('n', '<c-h>', ':BufferPrevious<cr>', {silent = true})
-- bind('n', '<c-l>', ':BufferNext<cr>', {silent = true})

-- telescope custom locations
-- bind('n', '<leader>fv', "<cmd>lua require('telescope.builtin').find_files { cwd = '~/.config/nvim', follow = true}<cr>", {silent = true})
-- bind('n', '<leader>fn', "<cmd>lua require('lcrown.telescope').grep_notes()<cr>", {silent = true})

-- custom navigation
-- bind('n', '<leader>p', "<cmd>lua require('telescope.builtin').find_files({follow = true})<cr>", {silent = true})
-- bind('n', '<leader>f', "<cmd>lua require('telescope.builtin').live_grep()<cr>", {silent = true})
-- bind('n', '<c-f>', "<cmd>lua require('telescope.builtin').live_grep()<cr>", {silent = true})
-- bind('n', '<c-p>', "<cmd>lua require('telescope.builtin').find_files()<cr>", {silent = true})

-- FloaTerm configuration
-- bind('n', "<leader>ft", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 zsh <CR> ")
-- bind('n', "t", ":FloatermToggle myfloat<CR>")
-- vim.keybind.set('t', "<Esc>", "<C-\\><C-n>:q<CR>")

-- open a new nvim terminal
-- bind('n', '<leader>t', ':terminal<cr>i')
-- bind('t', '<esc>', '<c-\\><c-n>')
-- bind('t', '<c-v><esc>', '<esc>')
--
-- open fancy split terminal
-- bind('n', '<c-t>', ':lua toggle_terminal()<CR>', {silent = true})
-- bind('i', '<c-t>', '<ESC>:lua toggle_terminal()<CR>', {silent = true})
-- bind('t', '<c-t>', '<c-\\><c-n>:lua toggle_terminal()<CR>', {silent = true})

-- rebinds to handle terminal usage and command execution
-- bind('n', '<leader>xc', ':vnew <bar> :setlocal buftype=nofile <bar> r !<space>')

-- go to the directory of the current buffer
-- bind('n', '<leader>c', ':cd %:p:h<cr>')
