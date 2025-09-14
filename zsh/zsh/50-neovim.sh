#!/bin/bash

# make the swp dir
test -d ~/.backup || mkdir ~/.backup

# neovim
alias vim="nvim"
alias v="nvim"
alias vimv='spushd ~/.config/nvim; nvim .; spopd'

# clean swap
alias swap_clean="rm -f \$HOME/.local/share/nvim/swap/*.s*"
alias swap_cd="cd \$HOME/.local/share/nvim/swap/"
alias swap_list="ls \$HOME/.local/share/nvim/swap/*.s*"

# editing my dotfiles
alias vimd="spushd \$DOTFILES; nvim .; spopd"

