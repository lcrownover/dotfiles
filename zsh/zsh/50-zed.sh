#!/bin/bash

alias z='zzed'
zzed() {
    case "$1" in
    "")
        zed .
        ;;
    d)
        zed ~/.dotfiles
        ;;
    r)
        zed ~/racs/racs-ansible
        ;;
    rd)
        zed ~/racs/racs-internal-docs
        ;;
    *)
        if [ -f "$1" ]; then
            zed "$1"
        else
            zed -n "$1"
        fi
        ;;
    esac
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
