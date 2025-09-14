#!/bin/bash

case "$DOT_OS" in
wsl)
    export GDRIVEDIR="/mnt/c/Users/Lucas\ Crownover/Google\ Drive/"
    ;;
*)
    # set gdrive to mirror, choose $HOME/.gdrive as the mirror location.
    #export GDRIVEDIR="$HOME/Library/CloudStorage/GoogleDrive-lcrownover127@gmail.com/My Drive"
    export GDRIVEDIR="$HOME/Google Drive/My Drive/"
    ;;
esac

export ONEDRIVEDIR="$HOME/OneDrive - University Of Oregon"
export DOTFILES="$HOME/.dotfiles"
export NOTESDIR="$GDRIVEDIR/notes"

alias cdgd="cd '$GDRIVEDIR'"
alias cdod="cd '$ONEDRIVEDIR'"

alias ibrew='arch -x86_64 /usr/local/homebrew/bin/brew'
