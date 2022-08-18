vim.opt.mouse:append('a')
vim.opt.clipboard = 'unnamed'
vim.opt.colorcolumn = '80,120'
vim.opt.cursorline = true
vim.opt.indentkeys:remove(':,<:>')
vim.opt.list = true
vim.opt.listchars:append({ tab = '├─', trail = '·' })
vim.opt.errorbells = false
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 4
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.undofile = true

-- fix background color in tmux
-- vim.opt.t_ut=

vim.opt.tabstop = 4
vim.opt.sts = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.g.mapleader = " "

vim.g.NERDTreeAutoDeleteBuffer = 1
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeDirArrows = 1
vim.g.NERDTreeQuitOnOpen = 1
vim.g.NERDTreeWinPos = "right"

-- vim-visual-multi maps
vim.cmd([[
  let g:VM_maps = {}
  let g:VM_maps["Undo"] = 'u'
  let g:VM_maps["Redo"] = '<C-r>'
]])

-- nvim-tree doesnt work with my symlink setup...
-- let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
-- let g:nvim_tree_quit_on_open = 1
-- let g:nvim_tree_git_hl = 1
-- let g:nvim_tree_add_trailing = 1
