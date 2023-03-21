return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "jayp0521/mason-null-ls.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_null_ls = require("mason-null-ls")

    mason.setup()

    mason_lspconfig.setup({
      automatic_installation = true,
      ensure_installed = {
        -- lsp servers
        "ansiblels",
        "awk_ls",
        "bashls",
        "clangd",
        "dockerls",
        "eslint",
        "gopls",
        "html",
        "marksman",
        "puppet",
        "pyright",
        "rust_analyzer",
        "solargraph",
        "svelte",
        "lua_ls",
        "terraformls",
        "tsserver",
        "vimls",
      },
    })

    mason_null_ls.setup({
      automatic_installation = true,
      ensure_installed = {
        "black",
        "rubocop",
        "stylua",
        "jq",
        "shfmt",
        "markdownlint",
        "prettier",
      },
    })

  end,
}
