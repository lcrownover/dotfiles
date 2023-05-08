-- To make the background solid while using Kitty
-- you have to change the background color in the kitty theme to a slightly different color
-- than the background color of this theme.
-- Specifically, change the kitty background color from 303446 to 303445 for catppuccin soft.


return {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.everforest_background = "soft"
        vim.g.everforest_better_performance = 1
        vim.cmd([[colorscheme everforest]])
        vim.g.lualine_theme = "everforest"
    end,
}

-- return {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     lazy = false,
--     priority = 1000, -- make sure to load this before all the other start plugins
--     config = function()
--     require("catppuccin").setup({
--         flavour = "frappe",
--         -- transparent_background = true,
--     })
--     vim.cmd.colorscheme("catppuccin")
--     vim.g.lualine_theme = "catppuccin"
--     end,
-- }
