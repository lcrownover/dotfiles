return {
  "mbbill/undotree",
  "tpope/vim-fugitive",
  "tpope/vim-eunuch",
  "christoomey/vim-tmux-navigator",
  "mfussenegger/nvim-dap",
  -- "mg979/vim-visual-multi", -- C-n add cursor on match

  -- appearance
  -- 'navarasu/onedark.nvim',
  -- 'sam4llis/nvim-tundra',
  -- 'tanvirtin/monokai.nvim',
  -- 'arcticicestudio/nord-vim',
  -- 'gruvbox-community/gruvbox',

  { "lewis6991/gitsigns.nvim", config = true },

  {
    "lervag/vimtex",
    ft = "tex",
    config = function()
      vim.g.vimtex_view_method = "zathura"
    end,
  },

  {
    "romgrk/barbar.nvim",
    event = "BufReadPre",
    config = function()
      require('bufferline').setup()
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
    "sindrets/diffview.nvim",
    cmd = "DiffViewOpen",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true,
  },

  {
    "numToStr/Comment.nvim",
    config = true,
  },

  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   config = true,
  -- },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*" }, { names = false })
    end,
  },

  {
    "folke/trouble.nvim",
    config = true,
  },

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
}
