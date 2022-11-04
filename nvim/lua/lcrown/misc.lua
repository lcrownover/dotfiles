require 'colorizer'.setup({
  '*'
}, { names = false }
)

-- trouble (quickfix for errors and lsp stuff)
require("trouble").setup {}

-- fidget gives a cool loading status for lsp
require "fidget".setup {}

require("nvim-surround").setup{}
