return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- telescope
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- autocompletion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'onsails/lspkind-nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'j-hui/fidget.nvim'
  use {'glepnir/lspsaga.nvim', branch = 'main'}

  -- bars
  use 'hoob3rt/lualine.nvim'
  use 'romgrk/barbar.nvim'

  -- theme
  use 'navarasu/onedark.nvim'
  -- use 'joshdick/onedark.vim'
  -- use 'glepnir/zephyr-nvim'
  --   use 'arcticicestudio/nord-vim'
  --   use 'gruvbox-community/gruvbox'
  --   use 'catppuccin/nvim', {'as': 'catppuccin'}

  use 'windwp/nvim-autopairs'
  use 'numToStr/Comment.nvim'   -- ctrl+c to comment
  use 'airblade/vim-gitgutter'
  use 'scrooloose/nerdtree'
  use 'mbbill/undotree'   -- leader u
  use 'mg979/vim-visual-multi'   -- C-n add cursor on match
  use 'godlygeek/tabular'
  use 'tpope/vim-fugitive'
  use 'norcalli/nvim-colorizer.lua'
  use 'folke/trouble.nvim'
  use 'tpope/vim-eunuch'   -- fancy commands like :ChMod, :Find
  use 'tpope/vim-surround'   -- cs{[ to change { to [
  use 'cappyzawa/trim.nvim'

  -- linting and language
  use 'rodjek/vim-puppet'
  use 'simrat39/rust-tools.nvim'
  use 'Vimjas/vim-python-pep8-indent'   -- fix until treesitter python and yaml indent is fixed

end)
