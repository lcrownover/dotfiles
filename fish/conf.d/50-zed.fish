function zzed
    switch "$argv[1]"
        case ''
            zed .
        case d
            zed ~/.dotfiles
        case r
            zed ~/racs/racs-ansible
        case rd
            zed ~/racs/racs-internal-docs
        case '*'
            if test -f "$argv[1]"
                zed "$argv[1]"
            else
                zed -n "$argv[1]"
            end
    end
end
alias z zzed

alias todo 'zed -n "$NOTESDIR"; zed "$NOTESDIR"/__todo.md'
alias notes 'zed -n "$NOTESDIR"'

function zed_dotfiles
    spushd .
    cd "$DOTFILES"
    zed .
    spopd
end
alias zdot zed_dotfiles
