require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt", "vim" },
})

require('Comment').setup()

require 'colorizer'.setup(
  { '*' },
  { names = false }
)

require 'trouble'.setup()

require 'nvim-surround'.setup()
