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
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
    require("catppuccin").setup({
        flavour = "frappe",
        -- transparent_background = true,
    })
    vim.cmd.colorscheme("catppuccin")
    vim.g.lualine_theme = "catppuccin"
    end,
}
