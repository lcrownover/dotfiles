call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-eunuch' " fancy commands like :ChMod, :Find
Plug 'tpope/vim-surround' " cs{[ to change { to [

call plug#end()

let mapleader = " "

echo "Loaded VSCode init"
