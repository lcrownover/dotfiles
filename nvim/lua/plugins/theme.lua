-- Change the colorscheme options here and it will change everywhere

-- catppuccin
-- local theme = 'catppuccin'
-- local style = 'frappe'

-- tundra
-- local theme = 'tundra'

-- tokyonight
local theme = 'tokyonight'
local style = 'storm'

-- onedark
-- local theme = 'onedark'
-- local style = "cool"

-- nord
-- local theme = 'nord'


function LoadTheme(theme_name)
  if theme_name == 'tokyonight' then
    vim.g.lualine_theme = 'tokyonight'
    require('tokyonight').setup({
      style = style,
      transparent = true,
      on_highlights = function(hl, c)
        hl.LineNr = { fg = c.comment }
        hl.CursorLineNr = { fg = c.comment }
        hl.NvimTreeNormal = { bg = "None" }
        hl.NvimTreeNormalNC = { bg = "None" }
        hl.NvimTreeWinSeparator = { bg = "None" }
        hl.TelescopeNormal = { bg = "None" }
        hl.TelescopeBorder = { bg = "None" }
        hl.TelescopePromptNormal = { bg = "None" }
        hl.TelescopePromptBorder = { bg = "None" }
        hl.TelescopePromptTitle = { bg = "None" }
        hl.TelescopePreviewTitle = { bg = "None" }
        hl.TelescopePreviewNormal = { bg = "None" }
        hl.TelescopePreviewBorder = { bg = "None" }
        hl.TelescopeResultsTitle = { bg = "None" }
      end,
    })
    vim.cmd [[colorscheme tokyonight]]

  elseif theme_name == 'catppuccin' then
    vim.g.lualine_theme = 'catppuccin'
    require('catppuccin').setup({ flavour = style, transparent_background = true })
    vim.cmd [[colorscheme catppuccin]]

  elseif theme_name == 'tundra' then
    vim.g.lualine_theme = 'tundra'
    require('nvim-tundra').setup({
      transparent_background = true,
    })
    vim.cmd [[colorscheme tundra]]

  elseif theme_name == 'onedark' then
    vim.g.lualine_theme = 'onedark'
    local onedark = require('onedark')

    -- get the palette information to override colors
    local all_palettes = require('onedark.palette')
    local palette = all_palettes.cool
    for k, v in pairs(all_palettes) do
      if k == style then palette = v end
    end

    onedark.setup {
      colors = {},
      style = style,
      transparent = true,
      lualine = { transparent = false },
      code_style = {
        comments = 'italic',
      },
      highlights = {
        CursorLineNr = { fg = palette.orange },
      },
    }
    onedark.load()

  elseif theme_name == 'nord' then
    vim.g.lualine_theme = 'nord'
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

  end
end

LoadTheme(theme)

local function lsp_status()
  if #vim.lsp.buf_get_clients() == 0 then
    return '⚠'
  else
    return '✓'
  end
end

require 'lualine'.setup {
  options = {
    theme = vim.g.lualine_theme,
  },
  sections = {
    lualine_b = { 'branch' },
    lualine_x = { 'encoding', 'fileformat', 'filetype', lsp_status },
  },
}
