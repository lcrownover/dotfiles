local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local mason_null_ls = require('mason-null-ls')

mason.setup()

mason_lspconfig.setup({
  automatic_installation = true,
  ensure_installed = {
    -- lsp servers
    'ansiblels',
    'awk_ls',
    'bashls',
    'clangd',
    'dockerls',
    'eslint',
    'gopls',
    'html',
    'marksman',
    'puppet',
    'pyright',
    'rust_analyzer',
    'solargraph',
    'sumneko_lua',
    'terraformls',
    'tsserver',
    'vimls',
  },
})

mason_null_ls.setup({
  automatic_installation = true,
  ensure_installed = {
    'blue',
    'rubocop',
    'stylua',
    'jq',
    'shfmt',
    'markdownlint',
  },
})
