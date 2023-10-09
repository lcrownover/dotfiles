return {
  "hoob3rt/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        theme = vim.g.lualine_theme,
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_b = { "branch" },
        lualine_x = { "encoding", "fileformat", "filetype" },
      },
    })
  end,
}
