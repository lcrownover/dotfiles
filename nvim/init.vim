" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

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

" code completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'onsails/lspkind-nvim'
Plug 'windwp/nvim-autopairs'
" Plug 'ray-x/lsp_signature.nvim'

" debugging
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

" fancy highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" ideally i can get rid of this at some point
Plug 'Vimjas/vim-python-pep8-indent'

" stylish!
Plug 'hoob3rt/lualine.nvim'
Plug 'romgrk/barbar.nvim'

" all the colors
Plug 'joshdick/onedark.vim'
Plug 'EdenEast/nightfox.nvim'
" Plug 'gruvbox-community/gruvbox'
Plug 'arcticicestudio/nord-vim'

" ctrl+c to comment
Plug 'numToStr/Comment.nvim'

" yay git
Plug 'airblade/vim-gitgutter'

" a= align by =
Plug 'godlygeek/tabular'

" scrub file navigation
Plug 'scrooloose/nerdtree'
" Plug 'kyazdani42/nvim-tree.lua'

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
Plug 'simrat39/rust-tools.nvim'

call plug#end()

" Get those settings
lua require('lcrown.theme')
lua require('lcrown.ui')
lua require('lcrown.telescope')
lua require('lcrown.treesitter')
lua require('lcrown.devicons')
lua require('lcrown.nvim-autopairs')
lua require('lcrown.lsp')
" lua require('lcrown.nvim-tree')
lua require('lcrown.nvim-comment')
lua require('lcrown.completion')
lua require('lcrown.debugging')
lua require('lcrown.custom')


"************************************"
"========   SET ME BABY  ============"
"************************************"

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

set tabstop=4 softtabstop=4
set expandtab

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

nnoremap <silent> <leader>fs :lua vim.lsp.buf.formatting()<cr>

" format files before saving
" autocmd BufWritePre *.lua,*.py :lua vim.lsp.buf.formatting_sync(nil, 1000)

augroup lcrown
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

nnoremap <leader>u :UndotreeShow<CR>
" nnoremap <c-h> :bprev<CR>
" nnoremap <c-l> :bnext<CR>

" convenience
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" break points!
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" moving lines of text
" vnoremap J :m '>+1<cr>gv=gv
" vnoremap K :m '<-2<cr>gv=gv
" inoremap <c-j> <esc>:m .+1<cr>==a
" inoremap <c-k> <esc>:m .-2<cr>==a
" nnoremap <leader>j :m .+1<cr>==
" nnoremap <leader>k :m .-2<cr>==

" bufferline
nnoremap <silent><c-h> :BufferPrevious<cr>
nnoremap <silent><c-l> :BufferNext<cr>

" telescope!
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files({follow = true})<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fp <cmd>lua require('telescope.builtin').file_browser()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fm <cmd>lua require('telescope.builtin').marks()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').resume()<cr>
nnoremap <leader>fv <cmd>lua require('telescope.builtin').find_files { cwd = '~/.config/nvim', follow = true}<cr>

nnoremap <leader>fn <cmd>lua require('lcrown.telescope').grep_notes()<cr>

" custom navigation
nnoremap <leader>p <cmd>lua require('telescope.builtin').find_files({follow = true})<cr>
nnoremap <leader>f <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>l <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <c-f> <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <c-p> <cmd>lua require('telescope.builtin').find_files()<cr>

" lsp remaps
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<cr>
" nnoremap <silent> <C-]> <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<cr>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<cr>
nnoremap <silent> <F2>  <cmd>lua vim.lsp.buf.rename()<cr>


"**************************************"
"======== LANGUAGE STUFF =============="
"**************************************"
au BufNewFile,BufRead *.rb,*.pp,*.lua,*.tf setlocal expandtab ts=2 sw=2 sts=2

"************************************"
"======== SPLITTING IS COOL ========="
"************************************"

" better split settings
nnoremap <c-w>- <c-w>s
nnoremap <c-w>\ <c-w>v
nnoremap <c-s-left> :vertical resize +1<cr>
nnoremap <c-s-right> :vertical resize -1<cr>
set splitbelow
set splitright


"************************************"
"======== NERD TREE SETTINGS ========"
"************************************"

noremap <c-b> :NERDTreeToggle<CR>
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeWinPos = "right"
nnoremap <leader>b :NERDTreeFind<cr>
" nvim-tree doesnt work with my symlink setup...
" let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
" let g:nvim_tree_quit_on_open = 1
" let g:nvim_tree_git_hl = 1
" let g:nvim_tree_add_trailing = 1
" nnoremap <C-b> :NvimTreeToggle<CR>
" nnoremap <leader>r :NvimTreeRefresh<CR>
" nnoremap <leader>b :NvimTreeFindFile<CR>

"************************************"
"========     DEBUGGING    =========="
"************************************"

nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<cr>
nnoremap <silent> <leader>dc :lua require'dap'.continue()<cr>
nnoremap <silent> <leader>di :lua require'dap'.step_into()<cr>
nnoremap <silent> <leader>du :lua require'dap'.step_out()<cr>
nnoremap <silent> <leader>do :lua require'dap'.step_over()<cr>
nnoremap <silent> <leader>dg :lua require'dapui'.toggle()<cr>
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F6> :lua require'dapui'.toggle()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>


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

nnoremap <leader>nu :set invnu<cr>:set invrnu<cr>:call ToggleSignColumn()<cr>

nnoremap <leader>; :norm A;<cr>

nnoremap <leader>vs <cmd>lua VSCode()<cr>

" visual multi maps
let g:VM_maps = {}
let g:VM_maps["Undo"] = 'u'
let g:VM_maps["Redo"] = '<C-r>'

" easy datetime stamp
nnoremap <leader>da :exe ':normal a _' . strftime('%c') . '_'<cr>

" easier commenting, for some reason C-_ means C-/
noremap <c-_> :norm gcc<cr>

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


