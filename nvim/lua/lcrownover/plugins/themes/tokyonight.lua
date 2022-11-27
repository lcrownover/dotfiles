require('tokyonight').setup({
  style = 'storm',
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
vim.g.lualine_theme = 'tokyonight'
