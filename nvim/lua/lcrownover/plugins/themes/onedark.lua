local onedark = require('onedark')

-- get the palette information to override colors
local all_palettes = require('onedark.palette')
local palette = all_palettes.cool
for k, v in pairs(all_palettes) do
  if k == 'cool' then palette = v end
end

onedark.setup {
  colors = {},
  style = 'cool',
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
vim.g.lualine_theme = 'onedark'
