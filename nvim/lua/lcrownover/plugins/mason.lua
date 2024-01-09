return {
  "williamboman/mason.nvim",
  event = "VeryLazy",
  build = ":MasonUpdate",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      automatic_installation = true,
      ensure_installed = {
        "ansiblels",
        "bashls",
        "dockerls",
        "gopls",
        "html",
        "marksman",
        "pyright",
        "rust_analyzer",
        "lua_ls",
        "terraformls",
        "svelte",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier",
        "stylua",
        "isort",
        "ruff",
        "eslint_d",
        "ansible-lint",
        "shfmt",
        "shellcheck",
        "markdownlint",
      },
    })
  end,
}
