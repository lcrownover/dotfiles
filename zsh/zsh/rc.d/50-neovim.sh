# make the swp dir
test -d ~/.backup || mkdir ~/.backup

# neovim
alias vim="nvim"
alias v="nvim"
alias vimv='spushd ~/.config/nvim; nvim init.lua; spopd'

# clean swap
alias swap_clean="rm -f \$HOME/.local/share/nvim/swap/*.s*"

# editing my dotfiles
alias vimd="spushd \$DOTFILES; nvim .; spopd"

# todo/notes
# alias todo="vim_notes __todo.md"
# alias notes="vim_notes"
vim_notes() {
    spushd .
    cd "$NOTESDIR" || return
    set_tmux_window_name "notes"
    if [ -z "$1" ]; then
        nvim .
    else
        nvim "$1"
    fi
    reset_tmux_window_name
    spopd
}
