-- return {
--   "folke/tokyonight.nvim",
--   lazy = false, -- make sure we load this during startup if it is your main colorscheme
--   priority = 1000, -- make sure to load this before all the other start plugins
--   config = function()
--     require("tokyonight").setup({
--       style = "storm",
--       transparent = true,
--       on_highlights = function(hl, c)
--         hl.LineNr = { fg = c.comment }
--         hl.CursorLineNr = { fg = c.comment }
--         hl.NvimTreeNormal = { bg = "None" }
--         hl.NvimTreeNormalNC = { bg = "None" }
--         hl.NvimTreeWinSeparator = { bg = "None" }
--         hl.TelescopeNormal = { bg = "None" }
--         hl.TelescopeBorder = { bg = "None" }
--         hl.TelescopePromptNormal = { bg = "None" }
--         hl.TelescopePromptBorder = { bg = "None" }
--         hl.TelescopePromptTitle = { bg = "None" }
--         hl.TelescopePreviewTitle = { bg = "None" }
--         hl.TelescopePreviewNormal = { bg = "None" }
--         hl.TelescopePreviewBorder = { bg = "None" }
--         hl.TelescopeResultsTitle = { bg = "None" }
--       end,
--     })
--     vim.cmd([[colorscheme tokyonight]])
--     vim.g.lualine_theme = "tokyonight"
--   end,
-- }
return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        require("catppuccin").setup({
            flavour = "frappe",
            -- transparent_background = true,
            -- To make the background solid while using the Kitty catppuccin theme,
            -- you have to change the background color in the kitty theme to a slightly different color
            -- than the background color of this theme.
            -- Specifically, change the kitty background color from 303446 to 303447.
        })
        vim.cmd.colorscheme("catppuccin")
        vim.g.lualine_theme = "catppuccin"
    end,
}

-- return {
-- "AlexvZyl/nordic.nvim",
-- lazy = false, -- make sure we load this during startup if it is your main colorscheme
-- priority = 1000, -- make sure to load this before all the other start plugins
-- config = function()
--     require("nordic").setup({
--         telescope = {
--             style = "classic",
--         },
--         transparent_bg = true,
--         override = {
--             NvimTreeNormal = { bg = "None" },
--             NvimTreeNormalNC = { bg = "None" },
--             NvimTreeWinSeparator = { bg = "None" },
--         },
--     })
--     require("nordic").load()
--     vim.g.lualine_theme = "nordic"
-- end,
-- }
