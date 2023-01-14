return {
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
    "sindrets/diffview.nvim",
    cmd = "DiffViewOpen",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("diffview").setup()
    end,
  },

  -- appearance
  -- 'navarasu/onedark.nvim',
  -- 'sam4llis/nvim-tundra',
  -- 'tanvirtin/monokai.nvim',
  -- 'arcticicestudio/nord-vim',
  -- 'gruvbox-community/gruvbox',

  {
    "numToStr/Comment.nvim",
    config = true,
  },
  "christoomey/vim-tmux-navigator",
  "airblade/vim-gitgutter",
  "mbbill/undotree", -- leader u
  "mg979/vim-visual-multi", -- C-n add cursor on match

  {
    "godlygeek/tabular",
    keys = {
      { "<Leader>a=", ":Tabularize /=<CR>" },
      { "<Leader>a=", ":Tabularize /=<CR>", mode = "x" },
      { "<Leader>a:", ":Tabularize /:\zs<CR>" },
      { "<Leader>a:", ":Tabularize /:\zs<CR>", mode = "x" },
    },
  },

  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gs", ":Git<cr>" },
      { "<leader>gc", ":Git commit<cr>" },
      { "<leader>gp", ":Git push<cr>" },
      { "<leader>gb", ":Git blame<cr>" },
      { "<leader>gd", ":Gvdiffsplit<cr>" },
      { "<leader>gh", ":diffget //2<cr>" },
      { "<leader>gl", ":diffget //3<cr>" },
    },
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*" }, { names = false })
    end,
  },
  {
    "folke/trouble.nvim",
    config = true,
    keys = {
      { "<leader>tt", ":Trouble<cr>", { silent = true } },
      { "<leader>tq", ":TroubleClose<cr>", { silent = true } },
      { "<leader>tr", ":TroubleRefresh<cr>", { silent = true } },
    },
  },

  {
    "tpope/vim-eunuch",
    keys = {
      { "<leader>xm", ":Chmod +x<cr>" },
    }, -- fancy commands like :ChMod, :Find

    {
      "kylechui/nvim-surround",
      config = true,
    },

    {
      "cappyzawa/trim.nvim",
      config = function()
        require("trim").setup({
          patterns = {
            [[%s/\s\+$//e]], -- remove unwanted spaces
            [[%s/\($\n\s*\)\+\%$//]], -- trim last line
            [[%s/\%^\n\+//]], -- trim first line
          },
        })
      end,
    },

    -- markdown preview
    {
      "iamcco/markdown-preview.nvim",
      ft = "md",
      build = function()
        vim.fn["mkdp#util#install"]()
      end,
    },
  },
}
