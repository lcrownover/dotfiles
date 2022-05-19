-- used for tmux color passing
vim.cmd [[
    if exists('+termguicolors')
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
    endif
]]


-- Change the colorscheme here and it will change everywhere

-- local theme = 'onedark'
-- local lualine_theme = theme

-- local theme = 'material'
-- local lualine_theme = theme

-- local theme = 'nightfox'
-- local lualine_theme = theme

local theme = 'nord'
local lualine_theme = theme

-- local theme = 'gruvbox'
-- local lualine_theme = theme

-- local theme = 'NeoSolarized'
-- local lualine_theme = 'solarized_dark'

vim.g.theme = theme
vim.g.lualine_theme = lualine_theme

if theme == 'onedark' then

  local original_colors = {
    red = { gui = "#E06C75", cterm = "204", cterm16 = "1" },
    dark_red = { gui = "#BE5046", cterm = "196", cterm16 = "9" },
    green = { gui = "#98C379", cterm = "114", cterm16 = "2" },
    yellow = { gui = "#E5C07B", cterm = "180", cterm16 = "3" },
    dark_yellow = { gui = "#D19A66", cterm = "173", cterm16 = "11" },
    blue = { gui = "#61AFEF", cterm = "39", cterm16 = "4" },
    purple = { gui = "#C678DD", cterm = "170", cterm16 = "5" },
    cyan = { gui = "#56B6C2", cterm = "38", cterm16 = "6" },
    white = { gui = "#ABB2BF", cterm = "145", cterm16 = "15" },
    black = { gui = "#282C34", cterm = "235", cterm16 = "0" },
  }
  local function c(color, gui)
    return { gui = gui, cterm = original_colors[color].cterm, cterm16 = original_colors[color].cterm16 }
  end
  -- vim.g.onedark_color_overrides = {
    -- red = c("red", "#D4777E"),
    -- dark_red = c("dark_red", "#B25951"),
    -- green = c("green", "#99BB80"),
    -- yellow = c("yellow", "#DABC85"),
    -- dark_yellow = c("dark_yellow", "#C69A70"),
    -- blue = c("blue", "#6FADE0"),
    -- purple = c("purple", "#C082D2"),
    -- cyan = c("cyan", "#60ADB7"),
    -- white = c("white", "#ACB2BD"),
    -- black = c("black", "#292C32"),
  -- }
  local colors = vim.api.nvim_eval("onedark#GetColors()")
  vim.g.onedark_terminal_italics = 1
  vim.cmd('colorscheme onedark')
  vim.cmd('highlight Normal guibg=None guifg=' .. colors.white.gui)
  vim.cmd('highlight Keyword guifg=' .. colors.purple.gui)
  vim.cmd('highlight CursorLineNR guibg=none guifg=' .. colors.yellow.gui)
  vim.cmd('highlight LineNr guifg=' .. colors.blue.gui)
  vim.cmd('highlight netrwDir guifg=' .. colors.blue.gui)
  vim.cmd('highlight qfFileName guifg=' .. colors.green.gui)
  vim.cmd('highlight TelescopeBorder guifg=' .. colors.blue.gui)

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

elseif theme == 'material' then
  vim.g.material_theme_style = 'default'
  vim.g.material_terminal_italics = 1
  vim.cmd('colorscheme material')

elseif theme == 'tokyonight' then
  vim.g.tokyonight_style = 'storm'
  vim.cmd('colorscheme tokyonight')

elseif theme == 'nord' then
  -- https://github.com/romgrk/barbar.nvim#highlighting
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
  vim.cmd('highlight TabLineFill guifg=#81a0c0')
  vim.cmd('highlight WarningMsg guifg=#be6069')

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
