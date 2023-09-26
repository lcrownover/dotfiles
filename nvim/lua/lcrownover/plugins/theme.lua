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
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme("onedark")
        vim.g.lualine_theme = "onedark"
    end
}

-- return {
--     "ful1e5/onedark.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         vim.cmd.colorscheme("onedark")
--         vim.g.lualine_theme = "onedark-nvim"
--     end
-- }

-- return {
--     "rebelot/kanagawa.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require('kanagawa').setup({
--             compile = true,             -- enable compiling the colorscheme
--             undercurl = true,            -- enable undercurls
--             keywordStyle = { italic = true},
--             statementStyle = { bold = false },
--             theme = "wave",              -- Load "wave" theme when 'background' option is not set
--             background = {               -- map the value of 'background' option to a theme
--                 dark = "wave",           -- try "dragon" !
--                 light = "lotus"
--             },
--         })
--         vim.cmd("colorscheme kanagawa")
--         vim.g.lualine_theme = "kanagawa"
--     end,
-- }


-- return {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     lazy = false,
--     priority = 1000, -- make sure to load this before all the other start plugins
--     config = function()
--         require("catppuccin").setup({
--             flavour = "frappe",
--             -- transparent_background = true,
--         })
--         vim.cmd.colorscheme("catppuccin")
--         vim.g.lualine_theme = "catppuccin"
--     end,
-- }

-- return {
--     "EdenEast/nightfox.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require('nightfox').setup({
--             options = {
--                 styles = {
--                     comments = "italic",
--                 }
--             }
--         })
--         vim.cmd.colorscheme("nordfox")
--         vim.g.lualine_theme = "nordfox"
--     end
-- }
