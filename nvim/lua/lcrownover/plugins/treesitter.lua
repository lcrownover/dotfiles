return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufEnter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = false, disable = { "html", "yaml", "python", "sh", "go" } },
      })
    end,
  }
}
