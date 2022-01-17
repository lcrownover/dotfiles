-- used for tmux color passing
vim.cmd [[
    if exists('+termguicolors')
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
    endif
]]


-- Change the colorscheme here and it will change everywhere

local theme = 'onedark'
local lualine_theme = theme

-- local theme = 'nightfox'
-- local lualine_theme = theme

-- local theme = 'nord'
-- local lualine_theme = theme

-- local theme = 'gruvbox'
-- local lualine_theme = theme

-- local theme = 'NeoSolarized'
-- local lualine_theme = 'solarized_dark'

vim.g.theme = theme
vim.g.lualine_theme = lualine_theme

if theme == 'onedark' then
  vim.g.onedark_terminal_italics = 1
  vim.cmd('colorscheme onedark')
  vim.cmd('highlight CursorLineNR guibg=none guifg=#eabe6f')
  vim.cmd('highlight Normal guibg=none guifg=#b9bfca')
  vim.cmd('highlight LineNr guifg=#44adf1')
  vim.cmd('highlight netrwDir guifg=#44adf1')
  vim.cmd('highlight qfFileName guifg=#86bf6d')
  vim.cmd('highlight TelescopeBorder guifg=#44adf1')

elseif theme == 'gruvbox' then
  vim.g.gruvbox_italic = 1
  vim.g.gruvbox_contrast_dark = 'hard'
  vim.g.gruvbox_invert_selection = '0'
  vim.cmd('colorscheme gruvbox')
  vim.cmd('highlight ColorColumn ctermbg=0 guibg=grey')
  vim.cmd('highlight SignColumn guibg=none')
  vim.cmd('highlight CursorLineNR guibg=none')
  vim.cmd('highlight Normal guibg=none guifg=#d2c49f')
  vim.cmd('highlight LineNr guifg=#5eacd3')
  vim.cmd('highlight netrwDir guifg=#5eacd3')
  vim.cmd('highlight qfFileName guifg=#aed75f')
  vim.cmd('highlight TelescopeBorder guifg=#5eacd3')

elseif theme == 'tokyonight' then
  vim.g.tokyonight_style = 'storm'
  vim.cmd('colorscheme tokyonight')

elseif theme == 'nord' then
  vim.g.nord_uniform_diff_background = 1
  vim.g.nord_italic = 1
  vim.g.nord_italic_comments = 1
  vim.g.nord_underline = 1
  vim.g.nord_bold_vertical_split_line = 1
  vim.cmd('colorscheme nord')
  vim.cmd('highlight Normal guibg=none')
  vim.cmd('highlight SignColumn guibg=none')
  vim.cmd('highlight CursorLineNR guibg=none guifg=#88c0d0')
  vim.cmd('highlight TelescopeBorder guifg=#81a1c1')
  vim.cmd('highlight netrwDir guifg=#4c556a')
  vim.cmd('highlight qfFileName guifg=#a3be8b')

elseif theme == 'NeoSolarized' then
  vim.cmd('colorscheme NeoSolarized')
  vim.g.neosolarized_contrast = "normal"
  vim.g.neosolarized_visibility = "normal"
  vim.g.neosolarized_vertSplitBgTrans = 0
  vim.g.neosolarized_bold = 1
  vim.g.neosolarized_underline = 1
  vim.g.neosolarized_italic = 1
  vim.g.neosolarized_termBoldAsBright = 1
  vim.cmd('highlight Normal guibg=none')
  vim.cmd('highlight SignColumn guibg=none')
  vim.cmd('highlight LineNr guifg=#719e07')
  vim.cmd('highlight CursorLineNR guibg=none guifg=#dc322f')
  vim.cmd('highlight TelescopeBorder guifg=#dc322f')
end




local function lsp_status()
    if #vim.lsp.buf_get_clients() == 0 then
        return '⚠'
    else
        return '✓'
    end
end

require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = theme,
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype', lsp_status},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

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
