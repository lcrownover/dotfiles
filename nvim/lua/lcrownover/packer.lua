local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- caching
  use 'lewis6991/impatient.nvim'

  -- dependencies for stuff
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'kyazdani42/nvim-web-devicons'

  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/playground'

  -- telescope
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'nvim-telescope/telescope.nvim'

  -- autocompletion
  use 'hrsh7th/nvim-cmp'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lsp'

  -- snippets
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'

  -- LSP
  use 'williamboman/mason.nvim'
  use "williamboman/mason-lspconfig.nvim"
  use 'WhoIsSethDaniel/mason-tool-installer.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use "jayp0521/mason-null-ls.nvim"
  use 'onsails/lspkind-nvim'
  use {'glepnir/lspsaga.nvim', branch = 'main'}
  use 'j-hui/fidget.nvim'

  -- diffview
  use 'sindrets/diffview.nvim'

  -- appearance
  use 'folke/tokyonight.nvim'
  -- use 'navarasu/onedark.nvim'
  -- use 'sam4llis/nvim-tundra'
  -- use 'tanvirtin/monokai.nvim'
  -- use 'arcticicestudio/nord-vim'
  -- use 'gruvbox-community/gruvbox'
  use 'hoob3rt/lualine.nvim'

  -- filetree
  -- use 'scrooloose/nerdtree'
  use 'kyazdani42/nvim-tree.lua'

  -- cool stuff
  use 'windwp/nvim-autopairs'
  use 'numToStr/Comment.nvim'
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

  -- markdown preview
  use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
  })

  if packer_bootstrap then
    require('packer').sync()
  end

end)
