return {
  "hoob3rt/lualine.nvim",
  lazy = false,
  config = function()
    require("lualine").setup({
      options = {
        section_separators = "",
        component_separators = "",
        theme = vim.g.lualine_theme,
      },
    })
  end,
}
