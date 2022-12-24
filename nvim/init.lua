-- load packer first
require('lcrownover.packer')
-- then caching
require('lcrownover.plugins.impatient')

require('lcrownover.core.options')
require('lcrownover.plugins.themes.tokyonight')
require('lcrownover.plugins.treesitter')
require('lcrownover.plugins.telescope')
require('lcrownover.plugins.nvim-cmp')
require('lcrownover.plugins.lsp.mason')
require('lcrownover.plugins.lsp.lspconfig')
require('lcrownover.plugins.lsp.lspsaga')
require('lcrownover.plugins.lsp.fidget')
require('lcrownover.plugins.nvim-tree')
require('lcrownover.plugins.lualine')
require('lcrownover.plugins.nvim-autopairs')
require('lcrownover.plugins.comment')
require('lcrownover.plugins.trouble')
require('lcrownover.plugins.colorizer')
require('lcrownover.plugins.diffview')
require('lcrownover.plugins.nvim-surround')
require('lcrownover.plugins.trim')

-- keymaps last
require('lcrownover.core.keymaps')

-- just for testing
-- require('lcrownover.core.playground')
