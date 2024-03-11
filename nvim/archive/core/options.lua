-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- nerd font
vim.g.have_nerd_font = true

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- mouse
vim.opt.mouse = "a"

-- clipboard
vim.opt.clipboard = "unnamedplus"

-- don't show the mode, it's already in the statusline
vim.opt.showmode = false

-- no startup message
vim.opt.shortmess:append({ I = true })

-- disable netrw - this needs to be set super early in the config
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- termguicolors - enable true colors support
vim.opt.termguicolors = true

-- updatetime - how many milliseconds until the swap file is written
vim.opt.updatetime = 250

-- timeoutlen - how many milliseconds until a keybinding times out
vim.opt.timeoutlen = 300

-- undofile - save undo history
vim.opt.undofile = true

-- cursorline - highlight the current line
vim.opt.cursorline = true

-- colorcolumn - highlight columns
vim.opt.colorcolumn = "80,120"

-- indentkeys:remove - remove some indent keys
-- opt.indentkeys:remove(":,<:>")

-- listchars - representation of whitespace characters
vim.opt.listchars:append({ tab = "├─", trail = "·", eol = "↲", nbsp = "␣" })

-- preview substitutions as you write
vim.opt.inccommand = "split"

-- wrap - wrap lines
vim.opt.wrap = false

-- scrolloff - how many lines to keep above and below the cursor
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

-- signcolumn - always show the sign column
vim.opt.signcolumn = "yes"

-- errorbells - turn that shit off
vim.opt.errorbells = false

-- searching
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>") -- clear hl on esc

-- default formatting
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.breakindent = true

-- splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- treesitter folding
vim.opt.foldmethod = "expr"
vim.opt.foldlevel = 99
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

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
