-- treesitter
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = "all",
      ignore_install = { "phpdoc" },
      highlight = { enable = true },
      indent = { enable = true, disable = { "html", "yaml", "python", "sh", "go" } },
    })
  end,
}
-- "nvim-treesitter/playground",
