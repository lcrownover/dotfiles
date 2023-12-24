return {
  "hoob3rt/lualine.nvim",
  lazy = false,
  config = function()
    require("lualine").setup({
      options = {
        theme = vim.g.lualine_theme,
      },
    })
  end,
}
