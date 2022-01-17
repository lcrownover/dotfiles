-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
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
map('n', 's-',  ':split<cr>',    {silent = true})
map('n', 'sv',  ':vsplit<cr>',   {silent = true})
map('n', 's\\', ':vsplit<cr>',   {silent = true})
map('n', 'sw',  ':close<cr>',    {silent = true})
map('n', 'sh',  '<c-w>h',        {silent = true})
map('n', 'sj',  '<c-w>j',        {silent = true})
map('n', 'sk',  '<c-w>k',        {silent = true})
map('n', 'sl',  '<c-w>l',        {silent = true})

-- nerdtree
map('n', '<leader>b', ':NERDTreeFind<cr>')
map('n', '<c-b>',     ':NERDTreeToggle<CR>')

-- nvim tree doesnt work with symlinks
-- map('n', '<C-b>',     ':NvimTreeToggle<CR>')
-- map('n', '<leader>r', ':NvimTreeRefresh<CR>')
-- map('n', '<leader>b', ':NvimTreeFindFile<CR>')


-- bufferline
map('n', '<c-h>', ':BufferPrevious<cr>',  {silent = true})
map('n', '<c-l>', ':BufferNext<cr>',      {silent = true})

-- telescope
map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files({follow = true})<cr>",   {silent = true})
map('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>",                   {silent = true})
map('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>",                     {silent = true})
map('n', '<leader>fp', "<cmd>lua require('telescope.builtin').file_browser()<cr>",                {silent = true})
map('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>",                   {silent = true})
map('n', '<leader>fm', "<cmd>lua require('telescope.builtin').marks()<cr>",                       {silent = true})
map('n', '<leader>fr', "<cmd>lua require('telescope.builtin').resume()<cr>",                      {silent = true})

-- telescope custom locations
map('n', '<leader>fv', "<cmd>lua require('telescope.builtin').find_files { cwd = '~/.config/nvim', follow = true}<cr>", {silent = true})
map('n', '<leader>fn', "<cmd>lua require('lcrown.telescope').grep_notes()<cr>",                                         {silent = true})

-- custom navigation
map('n', '<leader>p', "<cmd>lua require('telescope.builtin').find_files({follow = true})<cr>",  {silent = true})
map('n', '<leader>f', "<cmd>lua require('telescope.builtin').live_grep()<cr>",                  {silent = true})
map('n', '<leader>l', "<cmd>lua require('telescope.builtin').git_commits()<cr>",                {silent = true})
map('n', '<c-f>',     "<cmd>lua require('telescope.builtin').live_grep()<cr>",                  {silent = true})
map('n', '<c-p>',     "<cmd>lua require('telescope.builtin').find_files()<cr>",                 {silent = true})


-- lsp remaps
map('n', 'gd',          ':lua vim.lsp.buf.definition()<cr>',                    {silent = true})
map('n', 'gD',          ':lua vim.lsp.buf.declaration()<cr>',                   {silent = true})
map('n', 'gr',          ':lua vim.lsp.buf.references()<cr>',                    {silent = true})
map('n', 'gi',          ':lua vim.lsp.buf.implementation()<cr>',                {silent = true})
map('n', 'gn',          ':lua vim.lsp.buf.rename()<cr>',                        {silent = true})
map('n', 'K',           ':lua vim.lsp.buf.hover()<CR>',                         {silent = true})
map('n', '<C-k>',       ':lua vim.lsp.buf.signature_help()<CR>',                {silent = true})
map('n', 'ga',          ':lua vim.lsp.buf.code_action()<CR>',                   {silent = true})
map('n', '<leader>e',   ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',  {silent = true})
map('n', '<leader>fs',  ':lua vim.lsp.buf.formatting()<cr>',                    {silent = true})
map('n', '[d',          ':lua vim.lsp.diagnostic.goto_prev()<CR>',              {silent = true})
map('n', ']d',          ':lua vim.lsp.diagnostic.goto_next()<CR>',              {silent = true})



-- debugging
map('n', '<leader>db', ":lua require'dap'.toggle_breakpoint()<cr>",  {silent = true})
map('n', '<leader>dc', ":lua require'dap'.continue()<cr>",           {silent = true})
map('n', '<leader>di', ":lua require'dap'.step_into()<cr>",          {silent = true})
map('n', '<leader>du', ":lua require'dap'.step_out()<cr>",           {silent = true})
map('n', '<leader>do', ":lua require'dap'.step_over()<cr>",          {silent = true})
map('n', '<leader>dg', ":lua require'dapui'.toggle()<cr>",           {silent = true})
map('n', '<F5>',       ":lua require'dap'.continue()<CR>",           {silent = true})
map('n', '<F6>',       ":lua require'dapui'.toggle()<CR>",           {silent = true})
map('n', '<F10>',      ":lua require'dap'.step_over()<CR>",          {silent = true})
map('n', '<F11>',      ":lua require'dap'.step_into()<CR>",          {silent = true})
map('n', '<F12>',      ":lua require'dap'.step_out()<CR>",           {silent = true})

-- open a new nvim terminal
map('n', '<leader>t',   ':terminal<cr>i')
map('t', '<esc>',       '<c-\\><c-n>')
map('t', '<c-v><esc>',  '<esc>')

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
