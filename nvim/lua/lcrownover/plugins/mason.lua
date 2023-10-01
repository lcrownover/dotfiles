return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    print("Setting up Mason")

    mason.setup()

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
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier",
        "stylua",
        "isort",
        "black",
        "pylint",
        "eslint_d",
      },
    })
  end,
}
