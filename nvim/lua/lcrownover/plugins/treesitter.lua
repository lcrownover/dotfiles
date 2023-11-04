return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufEnter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "markdown", "markdown_inline" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
