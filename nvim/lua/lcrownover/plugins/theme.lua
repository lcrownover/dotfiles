-- return {
--     "sainnhe/everforest",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         vim.g.everforest_background = "medium"
--         vim.g.everforest_better_performance = 1
--         vim.cmd([[colorscheme everforest]])
--         vim.g.lualine_theme = "everforest"
--     end,
-- }

return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      -- flavour = "frappe",
      flavour = "macchiato",
    })
    vim.cmd.colorscheme("catppuccin")
    vim.g.lualine_theme = "catppuccin"
  end,
}

-- return {
--   "Mofiqul/vscode.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("vscode").setup({
--       italic_comments = true,
--     })
--     require("vscode").load()
--     vim.g.lualine_theme = "codedark"
--   end,
-- }

-- return {
--   "loctvl842/monokai-pro.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("monokai-pro").setup()
--     vim.cmd.colorscheme("monokai-pro")
--     vim.g.lualine_theme = "monokai-pro"
--   end
-- }
