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
    "AlexvZyl/nordic.nvim",
    -- dir = "/Users/lcrown/repos/nordic.nvim/",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        require("nordic").setup({
            telescope = {
                style = "classic",
            },
            transparent_bg = true,
            override = {
                NvimTreeNormal = { bg = "None" },
                NvimTreeNormalNC = { bg = "None" },
                NvimTreeWinSeparator = { bg = "None" },
                -- TelescopeNormal = { bg = "None" },
                -- TelescopeBorder = { bg = "None" },
                -- TelescopePromptNormal = { bg = "None" },
                -- TelescopePromptBorder = { bg = "None" },
                -- TelescopePromptTitle = { bg = "None" },
                -- TelescopePreviewTitle = { bg = "None" },
                -- TelescopePreviewNormal = { bg = "None" },
                -- TelescopePreviewBorder = { bg = "None" },
                -- TelescopeResultsTitle = { bg = "None" },
            },
        })
        require("nordic").load()
        vim.g.lualine_theme = "nordic"
    end,
}
