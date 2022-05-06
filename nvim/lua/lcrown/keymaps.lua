-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend("force", options, opts) end
    -- vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    vim.keymap.set(mode, lhs, rhs, options)
end

map('n', '<leader>u', ':UndotreeShow<CR>', {silent = true})

-- centering screen on next results
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- better joining
map('n', 'J', 'mzJ`z')

-- break points
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', '!', '!<c-g>u')
map('i', '?', '?<c-g>u')

-- splits
map('n', '<c-w>-', ':split<cr>', {silent = true})
map('n', '<c-w>\\', ':vsplit<cr>', {silent = true})
map('n', '<c-w>w', ':close<cr>', {silent = true})

-- nerdtree
map('n', '<leader>b', ':NERDTreeFind<cr>')
map('n', '<c-b>', ':NERDTreeToggle<CR>')

-- nvim tree doesnt work with symlinks
-- map('n', '<C-b>',     ':NvimTreeToggle<CR>')
-- map('n', '<leader>r', ':NvimTreeRefresh<CR>')
-- map('n', '<leader>b', ':NvimTreeFindFile<CR>')

-- bufferline
map('n', '<c-h>', ':BufferPrevious<cr>', {silent = true})
map('n', '<c-l>', ':BufferNext<cr>', {silent = true})

-- telescope
map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files({follow = true})<cr>", {silent = true})
map('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>", {silent = true})
map('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", {silent = true})
map('n', '<leader>fp', "<cmd>lua require('telescope.builtin').file_browser()<cr>", {silent = true})
map('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>", {silent = true})
map('n', '<leader>fm', "<cmd>lua require('telescope.builtin').marks()<cr>", {silent = true})
map('n', '<leader>fr', "<cmd>lua require('telescope.builtin').resume()<cr>", {silent = true})
map('n', '<leader>f;', "<cmd>lua require('telescope.builtin').resume()<cr>", {silent = true})

-- telescope custom locations
map('n', '<leader>fv', "<cmd>lua require('telescope.builtin').find_files { cwd = '~/.config/nvim', follow = true}<cr>", {silent = true})
map('n', '<leader>fn', "<cmd>lua require('lcrown.telescope').grep_notes()<cr>", {silent = true})

-- custom navigation
map('n', '<leader>p', "<cmd>lua require('telescope.builtin').find_files({follow = true})<cr>", {silent = true})
map('n', '<leader>f', "<cmd>lua require('telescope.builtin').live_grep()<cr>", {silent = true})
map('n', '<leader>l', "<cmd>lua require('telescope.builtin').git_commits()<cr>", {silent = true})
map('n', '<c-f>', "<cmd>lua require('telescope.builtin').live_grep()<cr>", {silent = true})
map('n', '<c-p>', "<cmd>lua require('telescope.builtin').find_files()<cr>", {silent = true})

-- fugitive
map('n', '<leader>gs', ':Git<cr>')
map('n', '<leader>gc', ':Git commit<cr>')
map('n', '<leader>gp', ':Git push<cr>')
map('n', '<leader>gb', ':Git blame<cr>')
map('n', '<leader>gd', ':Gvdiffsplit<cr>')
map('n', '<leader>gh', ':diffget //2<cr>')
map('n', '<leader>gl', ':diffget //3<cr>')

-- debugging
map('n', '<leader>db', ":lua require'dap'.toggle_breakpoint()<cr>", {silent = true})
map('n', '<leader>dc', ":lua require'dap'.continue()<cr>", {silent = true})
map('n', '<leader>di', ":lua require'dap'.step_into()<cr>", {silent = true})
map('n', '<leader>du', ":lua require'dap'.step_out()<cr>", {silent = true})
map('n', '<leader>do', ":lua require'dap'.step_over()<cr>", {silent = true})
map('n', '<leader>dg', ":lua require'dapui'.toggle()<cr>", {silent = true})
map('n', '<F5>', ":lua require'dap'.continue()<CR>", {silent = true})
map('n', '<F6>', ":lua require'dapui'.toggle()<CR>", {silent = true})
map('n', '<F10>', ":lua require'dap'.step_over()<CR>", {silent = true})
map('n', '<F11>', ":lua require'dap'.step_into()<CR>", {silent = true})
map('n', '<F12>', ":lua require'dap'.step_out()<CR>", {silent = true})

-- open a new nvim terminal
map('n', '<leader>t', ':terminal<cr>i')
map('t', '<esc>', '<c-\\><c-n>')
map('t', '<c-v><esc>', '<esc>')
-- open fancy split terminal
map('n', '<c-t>', ':lua toggle_terminal()<CR>', {silent = true})
map('i', '<c-t>', '<ESC>:lua toggle_terminal()<CR>', {silent = true})
map('t', '<c-t>', '<c-\\><c-n>:lua toggle_terminal()<CR>', {silent = true})

-- remaps to handle terminal usage and command execution
map('n', '<leader>xc', ':vnew <bar> :setlocal buftype=nofile <bar> r !<space>')

-- execute the current buffer with bash
map('n', '<leader>xb', ':w !bash<cr>')

-- change the mode to executable
map('n', '<leader>xm', ':Chmod +x<cr>')

-- execute current file
map('n', '<leader>xf', ':!%:p<cr>')

-- go to the directory of the current buffer
map('n', '<leader>c', ':cd %:p:h<cr>')

-- close the quickfix window
map('n', '<leader>c', ':cclose<cr>', {silent = true})

-- scratch buffers, normal or splits
map('n', '<leader>nn', ':enew<cr>')
map('n', '<leader>nv', ':vnew<cr>')
map('n', '<leader>nh', ':new<cr>')

-- diffing files
map('n', '<leader>d<', ':diffthis<cr>')
map('n', '<leader>d>', ':vsplit<cr>:diffthis<cr>:wincmd p<cr>:bprev<cr>')
map('n', '<leader>dq', ':diffoff<cr>')

-- toggle sign column for copy-paste
map('n', '<leader>nu', ':set invnu<cr>:set invrnu<cr>:call ToggleSignColumn()<cr>')

-- open vs code
map('n', '<leader>vs', '<cmd>lua VSCode()<cr>')

-- easy datetime stamp
map('n', '<leader>da', ":exe ':normal a _' . strftime('%c') . '_'<cr>")

-- easier commenting, for some reason C-_ means C-/
map('n', '<C-_>', ':norm gcc<cr>', {silent = true})
map('x', '<C-_>', ':norm gcc<cr>', {silent = true})

-- close buffer
map('n', '<leader>w', ':bd<cr>', {silent = true})

-- quick key for regex
map('n', '<leader>r', ':%s/')
map('x', '<leader>r', ':s/')

-- keep visual mode after indenting
map('x', '>', '>gv')
map('x', '<', '<gv')

-- tabularize
map('n', '<Leader>a=', ':Tabularize /=<CR>')
map('x', '<Leader>a=', ':Tabularize /=<CR>')
map('n', '<Leader>a:', ':Tabularize /:\zs<CR>')
map('x', '<Leader>a:', ':Tabularize /:\zs<CR>')

