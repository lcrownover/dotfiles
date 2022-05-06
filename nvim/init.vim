" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

" treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind-nvim'
Plug 'j-hui/fidget.nvim'


Plug 'hoob3rt/lualine.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'gruvbox-community/gruvbox'
" Plug 'overcache/NeoSolarized'

Plug 'windwp/nvim-autopairs'
Plug 'numToStr/Comment.nvim' " ctrl+c to comment
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree' " leader u
Plug 'mg979/vim-visual-multi' " C-n add cursor on match
Plug 'tpope/vim-eunuch' " fancy commands like :ChMod, :Find
Plug 'tpope/vim-surround' " cs{[ to change { to [
Plug 'godlygeek/tabular'
Plug 'tpope/vim-fugitive'

" linting and language
Plug 'rodjek/vim-puppet'
Plug 'simrat39/rust-tools.nvim'
Plug 'Vimjas/vim-python-pep8-indent' " fix until treesitter python and yaml indent is fixed

" Plug 'lcrownover/funzy.nvim'
" Plug 'kyazdani42/nvim-tree.lua'
" Plug 'nvim-treesitter/playground'
" Plug 'mfussenegger/nvim-dap' " debugging
" Plug 'rcarriga/nvim-dap-ui' " debugging

call plug#end()

" set mouse=a
set clipboard=unnamed
set colorcolumn=80,120
set cursorline
set indentkeys-=:,<:>
set iskeyword-=_
set list
set listchars=tab:├─,trail:·
set noerrorbells
set nohlsearch
set nowrap
set number
set relativenumber
set scrolloff=10
set shiftwidth=4
set signcolumn=yes
set termguicolors
set undofile

" fix background color in tmux
set t_ut=

set ts=4 sts=4 sw=4
set expandtab

set splitbelow
set splitright

let mapleader = " "

au BufNewFile,BufRead *.rb,*.pp,*.lua,*.tf setlocal expandtab ts=2 sw=2 sts=2

let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeWinPos = "right"

" nvim-tree doesnt work with my symlink setup...
" let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
" let g:nvim_tree_quit_on_open = 1
" let g:nvim_tree_git_hl = 1
" let g:nvim_tree_add_trailing = 1


" vim-visual-multi maps
let g:VM_maps = {}
let g:VM_maps["Undo"] = 'u'
let g:VM_maps["Redo"] = '<C-r>'


fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
nnoremap <leader><c-f> :call TrimWhitespace()<cr>


augroup autoformat
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

" Toggle signcolumn.
function! ToggleSignColumn()
    if !exists("b:signcolumn_on") || b:signcolumn_on
        set signcolumn=no
        let b:signcolumn_on=0
    else
        set signcolumn=yes
        let b:signcolumn_on=1
    endif
endfunction

lua require('lcrown.devicons')
lua require('lcrown.treesitter')
lua require('lcrown.lsp')
lua require('lcrown.theme')
lua require('lcrown.telescope')
lua require('lcrown.nvim-comment')
lua require('lcrown.keymaps')
lua require('lcrown.terminal')
" lua require('lcrown.debugging')
" lua require('lcrown.nvim-tree')
" lua require('lcrown.playground')
