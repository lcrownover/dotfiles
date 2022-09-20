-- managers
require('lcrown.packer')
require('lcrown.mason')

-- prereqs, base stuff
require('lcrown.sets')
require('lcrown.devicons')
require('lcrown.treesitter')

-- file navigation
require('lcrown.nvim-tree')

-- formatting is basic spacing setup for specific languages
require('lcrown.formatting')

-- language server setups
require('lcrown.lsp')
require('lcrown.lspsaga')

-- these configs have no order
require('lcrown.theme')
require('lcrown.telescope')
require('lcrown.nvim-comment')
require('lcrown.terminal')
require('lcrown.misc')

-- keymaps should be last
require('lcrown.keymaps')

-- require('lcrown.debugging')
-- require('lcrown.playground')
