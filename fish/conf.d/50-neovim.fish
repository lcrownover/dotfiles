test -d ~/.backup; or mkdir ~/.backup

alias vim nvim
alias v nvim

function vimv
    spushd ~/.config/nvim
    nvim init.lua
    spopd
end

alias swap_clean 'rm -f $HOME/.local/share/nvim/swap/*.s*'
alias swap_cd 'cd $HOME/.local/share/nvim/swap/'
alias swap_list 'ls $HOME/.local/share/nvim/swap/*.s*'

function vimd
    spushd $DOTFILES
    nvim .
    spopd
end
