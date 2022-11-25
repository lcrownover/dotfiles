return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- caching
  use 'lewis6991/impatient.nvim'

  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      'nvim-treesitter/playground'
    },
  }

  -- telescope
  use { 'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
      'kyazdani42/nvim-web-devicons',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
  }

  -- autocompletion
  use { 'hrsh7th/nvim-cmp',
    requires = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
  }

  -- LSP
  use { "williamboman/mason.nvim",
    requires = {
      "williamboman/mason-lspconfig.nvim",
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      "jayp0521/mason-null-ls.nvim",
      'onsails/lspkind-nvim',
      'jose-elias-alvarez/null-ls.nvim',
      'j-hui/fidget.nvim',
      { 'glepnir/lspsaga.nvim', branch = 'main' },
    },
  }
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- theme
  use 'folke/tokyonight.nvim'
  -- use 'navarasu/onedark.nvim'
  -- use 'sam4llis/nvim-tundra'
  -- use 'tanvirtin/monokai.nvim'
  -- use 'arcticicestudio/nord-vim'
  -- use 'gruvbox-community/gruvbox'

  use 'scrooloose/nerdtree'
  -- use 'kyazdani42/nvim-tree.lua'
  use 'windwp/nvim-autopairs'
  use 'numToStr/Comment.nvim'
  use 'hoob3rt/lualine.nvim'
  use 'christoomey/vim-tmux-navigator'
  use 'airblade/vim-gitgutter'
  use 'mbbill/undotree' -- leader u
  use 'mg979/vim-visual-multi' -- C-n add cursor on match
  use 'godlygeek/tabular'
  use 'tpope/vim-fugitive'
  use 'norcalli/nvim-colorizer.lua'

  use 'folke/trouble.nvim'
  use 'tpope/vim-eunuch' -- fancy commands like :ChMod, :Find
  use 'kylechui/nvim-surround'
  use 'cappyzawa/trim.nvim'

  -- linting and language
  use 'rodjek/vim-puppet'
  use 'simrat39/rust-tools.nvim'
  use 'Vimjas/vim-python-pep8-indent' -- fix until treesitter python and yaml indent is fixed
  use 'fatih/vim-go'

  -- debugging
  use 'mfussenegger/nvim-dap'

end)
