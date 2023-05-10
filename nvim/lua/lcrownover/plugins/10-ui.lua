return {
  {
    "sainnhe/everforest",
        lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_background = "medium"
      vim.g.everforest_better_performance = 1
      vim.cmd([[colorscheme everforest]])
      vim.g.lualine_theme = "everforest"
    end,
  },

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

  {
    "akinsho/bufferline.nvim",
    lazy = false,
    keys = {
      { "<C-n>", "<cmd>BufferLineCycleNext<cr>" },
      { "<C-p>", "<cmd>BufferLineCyclePrev<cr>" },
    },
    config = true,
  },
  {
    "hoob3rt/lualine.nvim",
    config = function()
      local function lsp_status()
        if #vim.lsp.get_active_clients() == 0 then
          return "⚠"
        else
          return "✓"
        end
      end

      require("lualine").setup({
        options = {
          theme = vim.g.lualine_theme,
        },
        sections = {
          lualine_b = { "branch" },
          lualine_x = { "encoding", "fileformat", "filetype", lsp_status },
        },
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<C-b>",     ":Neotree toggle<CR>",            silent = true },
      { "<leader>b", ":Neotree filesystem reveal<CR>", silent = true },
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        window = {
          position = "right",
        },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {
              "node_modules",
            },
            never_show = {
              ".DS_Store",
              "thumbs.db",
            },
          },
        },
        event_handlers = {
          {
            event = "file_opened",
            handler = function()
              --auto close
              require("neo-tree").close_all()
            end,
          },
        },
      })
    end,
  }
}
