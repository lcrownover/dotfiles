-- concise
local opt = vim.opt

-- no startup message
opt.shortmess:append({ I = true })

-- disable netrw - this needs to be set super early in the config
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- termguicolors - enable true colors support
opt.termguicolors = true

-- updatetime - how many milliseconds until the swap file is written
opt.updatetime = 1000

-- timeoutlen - how long to wait for a mapped sequence to complete
opt.timeoutlen = 1000

-- undofile - save undo history
opt.undofile = true

-- cursorline - highlight the current line
opt.cursorline = true

-- colorcolumn - highlight columns
opt.colorcolumn = "80,120"

-- indentkeys:remove - remove some indent keys
-- opt.indentkeys:remove(":,<:>")

-- listchars - representation of whitespace characters
opt.listchars:append({ tab = "├─", trail = "·", eol = "↲", space = "_" })

-- wrap - wrap lines
opt.wrap = false

-- line numbers
opt.number = true
opt.relativenumber = true

-- scrolloff - how many lines to keep above and below the cursor
opt.scrolloff = 10
opt.sidescrolloff = 10

-- signcolumn - always show the sign column
opt.signcolumn = "yes"

-- errorbells - turn that shit off
opt.errorbells = false

-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- mouse and clipboard
opt.mouse:append("a")
opt.clipboard = "unnamedplus"

-- searching
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true

-- default formatting
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.breakindent = true

-- splits
opt.splitbelow = true
opt.splitright = true

-- treesitter folding
opt.foldmethod = "expr"
opt.foldlevel = 99
opt.foldexpr = "nvim_treesitter#foldexpr()"

-- this will toggle the visibility of whitespace characters
function ToggleWhitespaceVisibility()
  opt.list = not opt.list:get()
end

-- this flashes the current selection when I yank it
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 100,
    })
  end,
})
