-- used for tmux color passing
vim.cmd [[
    if exists('+termguicolors')
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
    endif
]]

vim.cmd('set background=dark')


-- Change the colorscheme here and it will change everywhere

-- local theme = 'onedark'
local theme = 'gruvbox'


if theme == 'onedark' then
    vim.g.onedark_terminal_italics = 1
    vim.cmd('colorscheme onedark')

elseif theme == 'gruvbox' then
    vim.g.gruvbox_italic = 1
    vim.g.gruvbox_contrast_dark = 'hard'
    vim.g.gruvbox_invert_selection = '0'
    vim.cmd('colorscheme gruvbox')
    vim.cmd('highlight ColorColumn ctermbg=0 guibg=grey')
    vim.cmd('hi SignColumn guibg=none')
    vim.cmd('hi CursorLineNR guibg=None')
    vim.cmd('highlight Normal guibg=none')
    vim.cmd('highlight LineNr guifg=#5eacd3')
    vim.cmd('highlight netrwDir guifg=#5eacd3')
    vim.cmd('highlight qfFileName guifg=#aed75f')
    vim.cmd('hi TelescopeBorder guifg=#5eacd')

elseif theme == 'tokyonight' then
    vim.g.tokyonight_style = 'storm'
    vim.cmd('colorscheme tokyonight')

end


vim.g.theme = theme


-- gruvbox when im feeling froggy
-- vim.g.gruvbox_italic = 1
-- vim.cmd("colorscheme gruvbox")

-- tokyo night when im all about neovim
-- let g:tokyonight_style = 'night'
-- let g:lightline = { 'colorscheme': 'tokyonight' }
-- colorscheme tokyonight

-- ayu when spicy
-- let g:lightline = { 'colorscheme': 'ayu' }
-- let ayucolor='mirage'
-- colorscheme ayu

-- onedark when theres no place like home
-- let g:onedark_terminal_italics = 1
-- let g:lightline = { 'colorscheme': 'onedark' }
-- colorscheme onedark

-- solarized?
-- let g:lightline = { 'colorscheme': 'solarized' }
-- set background=dark
-- colorscheme solarized8

-- ITS NIGHTTIME
-- let g:lightline = { 'colorscheme': 'nightowl' }
-- colorscheme night-owl

-- nord!?
-- let g:lightline = { 'colorscheme': 'nord' }
-- colorscheme nord
