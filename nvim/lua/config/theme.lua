-- Change the colorscheme here and it will change everywhere

local theme = 'onedark'
-- local theme = 'gruvbox'


if theme == 'onedark' then
    vim.g.onedark_terminal_italics = 1
    vim.cmd('colorscheme onedark')

elseif theme == 'gruvbox' then
    vim.g.gruvbox_italic = 1
    vim.cmd('colorscheme gruvbox')

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
