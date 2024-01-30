return {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.everforest_background = "medium"
        vim.g.everforest_better_performance = 1
        vim.cmd([[colorscheme everforest]])
        vim.g.lualine_theme = "everforest"
    end,
}

-- return {
--   "catppuccin/nvim",
--   name = "catppuccin",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("catppuccin").setup({
--       -- flavour = "frappe",
--       flavour = "macchiato",
--     })
--     vim.cmd.colorscheme("catppuccin")
--     vim.g.lualine_theme = "catppuccin"
--   end,
-- }
--
