call plug#begin('~/.vim/plugged')

" testing my own plugin
"Plug 'lcrownover/funzy.nvim'

" telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" lsp!
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'

" fancy highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" stylish!
Plug 'itchyny/lightline.vim'

" all the colors
Plug 'joshdick/onedark.vim'
"Plug 'gruvbox-community/gruvbox'
"Plug 'shinchu/lightline-gruvbox.vim'

" Leader C to comment
Plug 'scrooloose/nerdcommenter'

" yay git
Plug 'airblade/vim-gitgutter'

"a= align by =
Plug 'godlygeek/tabular'

" scrub file navigation
Plug 'scrooloose/nerdtree'

" leader u
Plug 'mbbill/undotree'

"C-n add cursor on match
Plug 'mg979/vim-visual-multi'

"fancy commands like :ChMod, :Find
Plug 'tpope/vim-eunuch'

"cs{[ to change { to [
Plug 'tpope/vim-surround'

"linting and language
Plug 'rodjek/vim-puppet'

call plug#end()

" Get those settings
lua require('lcrown-config.telescope')
lua require('lcrown-config.treesitter')
lua require('lcrown-config.devicons')
lua require('lcrown-config.lspconfig')
lua require('lcrown-config.compe')


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
set noswapfile nobackup
set backupdir=~/.backup//
set directory=~/.backup//
set undodir=~/.backup//
set undofile
set incsearch
set termguicolors
set scrolloff=8
set colorcolumn=80
set signcolumn=yes
set cursorline
set clipboard=unnamed
"set shellcmdflag=-ic

" needed for lightline
set laststatus=2

" Extra space for messages
set cmdheight=2


"************************************"
"======== MAKE IT PRETTY ============"
"************************************"

" gruvbox when im feeling froggy
"let g:gruvbox_italic=1
"let g:lightline = {}
"let g:lightline.colorscheme = 'gruvbox'
"colorscheme gruvbox

" tokyo night when im all about neovim
"let g:tokyonight_style = "night"
"let g:lightline = { 'colorscheme': 'tokyonight' }
"colorscheme tokyonight

" ayu when spicy
"let g:lightline = { 'colorscheme': 'ayu' }
"let ayucolor="mirage"
"colorscheme ayu

" onedark when theres no place like home
let g:onedark_terminal_italics = 1
let g:lightline = { 'colorscheme': 'onedark' }
colorscheme onedark

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
nnoremap <leader>f' <cmd>lua require('telescope.builtin').marks()<cr>

" custom navigation
nnoremap <leader>p <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>f <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>t <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>l <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <c-f> <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <c-p> <cmd>lua require('telescope.builtin').find_files()<cr>

" compe
set completeopt=menuone,noselect
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" lsp remaps
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> <C-]> <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<cr>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<cr>

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

" just a quicker way to execute current file
nnoremap <leader>x :!%:p<cr>

" go to the directory of the current buffer
nnoremap <leader>c :cd %:p:h<cr>

" easier commenting, for some reason C-_ means C-/
map <c-_> <Leader>c<Space>

" highlight search
map <Leader>h :noh<CR>

" close buffer
map <Leader>w :bd<CR>

"quick key for regex
nnoremap <leader>r :%s/
vmap <leader>r :s/

" keep visual mode after indenting
vmap > >gv

if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif


