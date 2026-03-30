switch "$DOT_OS"
    case wsl
        set -gx GDRIVEDIR "/mnt/c/Users/Lucas Crownover/Google Drive/"
    case '*'
        set -gx GDRIVEDIR "$HOME/Google Drive/My Drive/"
end

set -gx ONEDRIVEDIR "$HOME/OneDrive - University Of Oregon"
set -gx DOTFILES "$HOME/.dotfiles"
set -gx NOTESDIR "$GDRIVEDIR/notes"

alias cdgd "cd '$GDRIVEDIR'"
alias cdod "cd '$ONEDRIVEDIR'"

alias ibrew 'arch -x86_64 /usr/local/homebrew/bin/brew'
