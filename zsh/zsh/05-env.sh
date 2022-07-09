case "$OS" in
    wsl)
        export GDRIVEDIR="/mnt/c/Users/Lucas\ Crownover/Google\ Drive/"
        ;;
    *)
        export GDRIVEDIR="$HOME/.gdrive"
        ;;
esac

export ONEDRIVEDIR="$HOME/OneDrive - University Of Oregon"
export DOTFILES="$HOME/.dotfiles"
export NOTESDIR="$GDRIVEDIR/notes"

alias cdgd="cd '$GDRIVEDIR'"
alias cdod="cd '$ONEDRIVEDIR'"

alias ibrew='arch -x86_64 /usr/local/homebrew/bin/brew'
