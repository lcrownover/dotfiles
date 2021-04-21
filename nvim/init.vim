call plug#begin('~/.vim/plugged')

" stylish!
Plug 'itchyny/lightline.vim'

" all the colors
Plug 'ayu-theme/ayu-vim'
Plug 'gruvbox-community/gruvbox'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'joshdick/onedark.vim'

" Leader C to comment
Plug 'scrooloose/nerdcommenter'

" yay git
Plug 'airblade/vim-gitgutter'

"a= align by =
Plug 'godlygeek/tabular'

" telescope!
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'sharkdp/bat'
Plug 'sharkdp/fd'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'neovim/nvim-lspconfig'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" scrub file navigation
Plug 'scrooloose/nerdtree'

" leader u
Plug 'mbbill/undotree'

"C-n add cursor on match
"C-A-n select all matches
Plug 'mg979/vim-visual-multi'

"fancy commands like :ChMod, :Find
Plug 'tpope/vim-eunuch'

"cs{[ to change { to [
Plug 'tpope/vim-surround'

"linting and language
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rodjek/vim-puppet'

"write things in pairs automatically
Plug 'jiangmiao/auto-pairs'

call plug#end()


"************************************"
"======== FUNCTIONALITY ============="
"************************************"
let mapleader = " "

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup lcrown
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

nnoremap <leader>u :UndotreeShow<CR>
nnoremap <c-h> :bprev<CR>
nnoremap <c-l> :bnext<CR>


"************************************"
"======== GO GO PUPPET =============="
"************************************"
au BufNewFile,BufRead *.rb,*.pp setlocal noet ts=2 sw=2 sts=2


"************************************"
"======== SPLITTING IS COOL ========="
"************************************"

" better split settings
nnoremap <Leader>- <c-w>s
nnoremap <Leader>w\ <c-w>v
nnoremap <leader>wj <c-w><c-j>
nnoremap <leader>wk <c-w><c-k>
nnoremap <leader>wl <c-w><c-l>
nnoremap <leader>wh <c-w><c-h>
set splitbelow
set splitright


"************************************"
"======== BUFFER SWITCHING =========="
"************************************"

" fast buffer ls
map <Leader>b :ls<CR>
map <Leader>bh :bprev<CR>
map <Leader>bl :bnext<CR>


"************************************"
"======== NERD TREE SETTINGS ========"
"************************************"

" open nerdtree with ctrl p
map <c-p> :NERDTreeToggle<CR>
" nerdtree settings
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1
" open current buffer in NERDTree
map <leader>p :NERDTreeFind<cr>


"************************************"
"======== CUSTOM SHORTCUTS =========="
"************************************"

" toggle mouse mode
map <Leader>m :set invmouse<CR>

" easier commenting, for some reason C-_ means C-/
map <c-_> <Leader>c<Space>

" highlight search
map <Leader>h :noh<CR>

 "quick key for regex
map <leader>r :%s/

" faster display of registers
map <Leader>c :reg<CR>

" keep visual mode after indenting
"vmap <tab> >gvV

if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif


set clipboard=unnamed
