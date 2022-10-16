require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  ignore_install = { "phpdoc" },
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
  indent = {
    disable = {
      "html",
      "yaml",
      "python",
      "sh",
    },
  },
}
