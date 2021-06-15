call plug#begin('~/.vim/plugged')

" telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'

" fancy highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" stylish!
Plug 'itchyny/lightline.vim'

" all the colors
Plug 'ayu-theme/ayu-vim'
Plug 'gruvbox-community/gruvbox'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'joshdick/onedark.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'arcticicestudio/nord-vim'
Plug 'haishanh/night-owl.vim'

" Leader C to comment
Plug 'scrooloose/nerdcommenter'

" yay git
Plug 'airblade/vim-gitgutter'

"a= align by =
Plug 'godlygeek/tabular'

" oh yeah
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'

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
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rodjek/vim-puppet'

"write things in pairs automatically
Plug 'jiangmiao/auto-pairs'

call plug#end()

" Get those settings
lua require('lcrown.telescope')
lua require('lcrown.treesitter')
lua require('lcrown.devicons')
lua require('lcrown.lspconfig')
lua require('lcrown.compe')


"************************************"
"========   SET ME BABY  ============"
"************************************"

set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set colorcolumn=80
set signcolumn=yes
set cursorline
set clipboard=unnamed

" needed for lightline
set laststatus=2

" Extra space for messages
set cmdheight=2


"************************************"
"======== MAKE IT PRETTY ============"
"************************************"

" gruvbox when im feeling froggy
let g:gruvbox_italic=1
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
colorscheme gruvbox

" ayu when spicy
"let g:lightline = { 'colorscheme': 'ayu' }
"let ayucolor="mirage"
"colorscheme ayu

" onedark when theres no place like home
"let g:onedark_terminal_italics = 1
"let g:lightline = { 'colorscheme': 'onedark' }
"colorscheme onedark

" solarized?
"let g:lightline = { 'colorscheme': 'solarized' }
"set background=dark
"colorscheme solarized8

" ITS NIGHTTIME
"let g:lightline = { 'colorscheme': 'nightowl' }
"colorscheme night-owl

" nord!?
"let g:lightline = { 'colorscheme': 'nord' }
"colorscheme nord

" used for tmux color passing
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"************************************"
"======== FUNCTIONALITY ============="
"************************************"
let mapleader = " "

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

" telescope!
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" custom navigation
nnoremap <leader>p <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>f <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>t <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <c-f> <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <c-p> <cmd>lua require('telescope.builtin').find_files()<cr>

" compe
set completeopt=menuone,noselect
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" fzf yay
"nnoremap <leader>ff :Files<cr>
"nnoremap <leader>fg :Ag<cr>
"nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
"nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>


"************************************"
"======== GO GO PUPPET =============="
"************************************"
au BufNewFile,BufRead *.rb,*.pp setlocal expandtab ts=2 sw=2 sts=2


"************************************"
"======== SPLITTING IS COOL ========="
"************************************"

" better split settings
nnoremap <c-w>- <c-w>s
nnoremap <c-w>\ <c-w>v
set splitbelow
set splitright


"************************************"
"======== NERD TREE SETTINGS ========"
"************************************"

" open nerdtree with ctrl d
map <c-b> :NERDTreeToggle<CR>
" nerdtree settings
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1
" open current buffer in NERDTree
map <leader>b :NERDTreeFind<cr>


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


