function vscode
    switch "$argv[1]"
        case ''
            code .
        case d
            code ~/.dotfiles
        case r
            code ~/racs/racs-ansible
        case rd
            code ~/racs/racs-internal-docs
        case '*'
            if test -f "$argv[1]"
                code -r "$argv[1]"
            else
                code -n "$argv[1]"
            end
    end
end
alias c vscode

function vscode_dotfiles
    spushd .
    cd "$DOTFILES"
    code .
    spopd
end
alias cdot vscode_dotfiles
