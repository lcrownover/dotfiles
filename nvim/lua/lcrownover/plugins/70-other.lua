return {
  {
    "numToStr/Comment.nvim",
    config = true,
  },

  {
    "sindrets/diffview.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true,
  },

  {
    "tpope/vim-fugitive",
    config = true,
    keys = {
      { "<leader>gs", ":Git<cr>" },
      { "<leader>gp", ":Git pull<cr>" },
      { "<leader>gP", ":Git push<cr>" },
      { "<leader>gb", ":Git blame<cr>" },
      { "<leader>gd", ":Gvdiffsplit<cr>" },
      { "<leader>gh", ":diffget //2<cr>" },
      { "<leader>gl", ":diffget //3<cr>" },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    config = true
  },

  {
    "iamcco/markdown-preview.nvim",
    ft = "md",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        disable_filetype = { "TelescopePrompt", "vim" },
      })
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*" }, { names = false })
    end,
  },

  {
    "kylechui/nvim-surround",
    config = true,
  },

  {
    "nvim-telescope/telescope.nvim",
    event = "BufEnter",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>ff", "<cmd>lua require('telescope.builtin').find_files({follow = true})<cr>", silent = true },
      { "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>",                 silent = true },
      { "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>",                   silent = true },
      { "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>",                 silent = true },
      { "<leader>f;", "<cmd>lua require('telescope.builtin').resume()<cr>",                    silent = true },
      { "<leader>fq", "<cmd>lua require('telescope.builtin').quickfix()<cr>",                  silent = true },
      { "<leader>fk", "<cmd>lua require('telescope.builtin').keymaps()<cr>",                   silent = true },
      { "<leader>fc", "<cmd>lua require('telescope.builtin').git_commits()<cr>",               silent = true },
      { "<leader>fs", "<cmd>lua require('telescope.builtin').git_status()<cr>",                silent = true },
      { "<leader>fa", "<cmd>lua require('telescope.builtin').autocommands()<cr>",              silent = true },
      { "<leader>fl", "<cmd>lua require('telescope.builtin').highlights()<cr>",                silent = true },
    },
    config = function()
      local file_ignore_patterns = {
        "node_modules",
        "Music",
        "Library",
        "venv",
      }
      require("telescope").setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",
          },
        },
        defaults = {
          -- added "follow" to the other defaults so it follows symlinks
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--follow",
          },
          file_ignore_patterns = file_ignore_patterns,
          set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
          mappings = {
            i = {
              ["<c-k>"] = require("telescope.actions").move_selection_previous,
              ["<c-j>"] = require("telescope.actions").move_selection_next,
            },
            n = {
              ["<c-k>"] = require("telescope.actions").move_selection_previous,
              ["<c-j>"] = require("telescope.actions").move_selection_next,
            },
          },
        },
        pickers = {
          buffers = {
            sort_lastused = true,
            mappings = {
              i = { ["<leader>w"] = require("telescope.actions").delete_buffer },
              n = { ["<leader>w"] = require("telescope.actions").delete_buffer },
            },
          },
        },
      })
      require("telescope").load_extension("fzf")
    end,
  },

  {
    "cappyzawa/trim.nvim",
    config = function()
      require("trim").setup({
        patterns = {
          [[%s/\s\+$//e]],          -- remove unwanted spaces
          [[%s/\($\n\s*\)\+\%$//]], -- trim last line
          [[%s/\%^\n\+//]],         -- trim first line
        },
      })
    end,
  },

  {
    "folke/trouble.nvim",
    config = true,
    keys = {
      { "<leader>tt", ":Trouble<cr>",        silent = true },
      { "<leader>tq", ":TroubleClose<cr>",   silent = true },
      { "<leader>tr", ":TroubleRefresh<cr>", silent = true },
    },
  },

  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", ":UndotreeShow<CR>", silent = true },
    },
  },

  {
    "tpope/vim-eunuch",
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  {
    {
      "lervag/vimtex",
      ft = "tex",
      config = function()
        vim.g.vimtex_view_method = 'zathura'
        vim.api.nvim_create_user_command("OpenZathuraPDF", function()
          -- vim.cmd[[execute "normal \<Plug>(vimtex-compile)"]]
          local current_filepath = vim.fn.expand('%:p')
          local pdf_filepath = string.gsub(current_filepath, ".tex", ".pdf")
          io.popen(string.format("zathura %s &", pdf_filepath))
        end, {})
        -- vim.api.nvim_create_autocmd("BufWritePost", {
        --   pattern = "*.tex",
        --   callback = function()
        --     -- vim.fn('<Plug>(vimtex-compile)')
        --   end
        -- })
      end
    }
  },

}
