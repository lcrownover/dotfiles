-- concise
local opt = vim.opt

-- nvim-tree
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- leader
vim.g.mapleader = " "

-- mouse and clipboard
opt.mouse:append('a')
opt.clipboard = 'unnamed'

-- searching
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true

-- appearance
opt.termguicolors = true
opt.undofile = true
opt.cursorline = true
-- opt.colorcolumn = '80,120'
opt.indentkeys:remove(':,<:>')
opt.listchars:append({ tab = '├─', trail = '·', eol = '↲', space = "_"})
opt.wrap = false
opt.number = true
opt.relativenumber = true
opt.scrolloff = 10
opt.shiftwidth = 4
opt.signcolumn = 'yes'
opt.errorbells = false

-- default formatting
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- splits
opt.splitbelow = true
opt.splitright = true

-- treesitter folding
opt.foldmethod = 'expr'
opt.foldlevel = 99
opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- vim.g.NERDTreeAutoDeleteBuffer = 1
-- vim.g.NERDTreeMinimalUI = 1
-- vim.g.NERDTreeDirArrows = 1
-- vim.g.NERDTreeQuitOnOpen = 1
-- vim.g.NERDTreeWinPos = "right"

-- vim-visual-multi maps
-- vim.cmd([[
--   let g:VM_maps = {}
--   let g:VM_maps["Undo"] = 'u'
--   let g:VM_maps["Redo"] = '<C-r>'
-- ]])

function ToggleWhitespaceVisibility()
  opt.list = not opt.list:get()
end
