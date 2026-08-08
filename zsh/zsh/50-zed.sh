ln -sf "$HOME/.config/zsh/scripts/zed-manager" "$HOME/.local/bin/zed-manager"

alias z='zzed'
zzed() {
    if [ -z "$1" ]; then
        location=$(zed-manager "$1" | fzf)
    else
        location="$1"
    fi
    if [[ "$location" != "" ]]; then
        zed -n "$location"
    fi
}

alias todo="zed -n \"\$NOTESDIR\"; zed \"\$NOTESDIR\"/__todo.md"
alias notes="zed -n \"\$NOTESDIR\""

function zed_dotfiles() {
    spushd
    cd "$DOTFILES" || return
    zed .
    spopd
}
alias zdot="zed_dotfiles"
