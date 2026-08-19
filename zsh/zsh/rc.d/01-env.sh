case "$(uname -a)" in
Darwin*)
    export DOT_OS="mac"
    ;;
*WSL*)
    export DOT_OS="wsl"
    ;;
*)
    export DOT_OS="linux"
    ;;
esac

case "$DOT_OS" in
wsl)
    export GDRIVEDIR="/mnt/c/Users/Lucas\ Crownover/Google\ Drive/"
    ;;
*)
    export GDRIVEDIR="$HOME/Google Drive/My Drive/"
    ;;
esac

export ONEDRIVEDIR="$HOME/OneDrive - University Of Oregon"
export DOTFILES="$HOME/.dotfiles"
export NOTESDIR="$GDRIVEDIR/notes"

alias cdgd="cd '$GDRIVEDIR'"
alias cdod="cd '$ONEDRIVEDIR'"
alias bat="bat --theme=ansi"

export HOMEBREW_BINDIR="/opt/homebrew/bin"
