call plug#begin('~/.vim/plugged')

" testing my own plugin
" Plug 'lcrownover/funzy.nvim'

" telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'

" fancy highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" stylish!
Plug 'hoob3rt/lualine.nvim'

" all the colors
Plug 'joshdick/onedark.vim'
Plug 'gruvbox-community/gruvbox'

" ctrl+c to comment
Plug 'terrortylor/nvim-comment'

" yay git
Plug 'airblade/vim-gitgutter'

" a= align by =
Plug 'godlygeek/tabular'

" scrub file navigation
Plug 'scrooloose/nerdtree'

" leader u
Plug 'mbbill/undotree'

" C-n add cursor on match
Plug 'mg979/vim-visual-multi'

" fancy commands like :ChMod, :Find
Plug 'tpope/vim-eunuch'

" cs{[ to change { to [
Plug 'tpope/vim-surround'

" linting and language
Plug 'rodjek/vim-puppet'

call plug#end()

" Get those settings
lua require('lcrown.theme')
lua require('lcrown.lualine')
lua require('lcrown.telescope')
lua require('lcrown.treesitter')
lua require('lcrown.devicons')
lua require('lcrown.lspconfig')
lua require('lcrown.compe')
lua require('lcrown.nvim-comment')


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
set undofile
set termguicolors
set scrolloff=10
set colorcolumn=80,120
set signcolumn=yes
set cursorline
set clipboard=unnamed
set iskeyword-=_

set list
set listchars=tab:├─,trail:·

" Extra space for messages
set cmdheight=2


"************************************"
"======== FUNCTIONALITY ============="
"************************************"

let mapleader = " "

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
nnoremap <leader><c-f> :call TrimWhitespace()<cr>

augroup lcrown
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

nnoremap <leader>u :UndotreeShow<CR>
nnoremap <c-h> :bprev<CR>
nnoremap <c-l> :bnext<CR>

" telescope!
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files({follow = true})<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fp <cmd>lua require('telescope.builtin').file_browser()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fm <cmd>lua require('telescope.builtin').marks()<cr>
nnoremap <leader>fv <cmd>lua require('telescope.builtin').find_files { cwd = '~/.config/nvim', follow = true}<cr>

" custom navigation
nnoremap <leader>p <cmd>lua require('telescope.builtin').find_files({follow = true})<cr>
nnoremap <leader>f <cmd>lua require('telescope.builtin').live_grep()<cr>
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
"========     EXEGGUTOR    =========="
"************************************"

" open a new nvim terminal
if has('nvim')
    nnoremap <leader>t :terminal<cr>i
    tnoremap <esc> <c-\><c-n>
    tnoremap <c-v><esc> <esc>
endif

" remaps to handle terminal usage and command execution
nnoremap <leader>xc :vnew <bar> :setlocal buftype=nofile <bar> r !<space>

" execute the current buffer with bash
nnoremap <leader>xb :w !bash<cr>

" change the mode to executable
nnoremap <leader>xm :Chmod +x<cr>

" execute current file
nnoremap <leader>xf :!%:p<cr>

" go to the directory of the current buffer
nnoremap <leader>c :cd %:p:h<cr>


"************************************"
"======== CUSTOM SHORTCUTS =========="
"************************************"

nnoremap <leader>nn :enew<cr>
nnoremap <leader>nv :vnew<cr>
nnoremap <leader>nh :new<cr>

nnoremap <leader>d< :diffthis<cr>
nnoremap <leader>d> :vsplit<cr>:diffthis<cr>:wincmd p<cr>:bprev<cr>
nnoremap <leader>dq :diffoff<cr>

" visual multi maps
let g:VM_maps = {}
let g:VM_maps["Undo"] = 'u'
let g:VM_maps["Redo"] = '<C-r>'

" easy datetime stamp
nnoremap <leader>da :exe ':normal a _' . strftime('%c') . '_'<cr>

" easier commenting, for some reason C-_ means C-/
noremap <c-_> :CommentToggle<cr>

" close buffer
nnoremap <leader>w :bd<cr>

"quick key for regex
nnoremap <leader>r :%s/
vmap <leader>r :s/

" keep visual mode after indenting
vmap > >gv
vmap < <gv

if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif


