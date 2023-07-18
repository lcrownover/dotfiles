# vscode
alias c='vscode'
vscode() {
    case "$1" in
    "")
        code .
        ;;
    *)
        if [ -f "$1" ]; then
            code -r "$1"
        else
            code -n "$1"
        fi
        ;;
    esac
}

alias todo="code -n $NOTESDIR; code -r $NOTESDIR/__todo.md"
alias notes="code -n $NOTESDIR"

function vscode_dotfiles() {
    spushd
    cd $DOTFILES
    code .
    spopd
}
alias cdot="vscode_dotfiles"

# vscode
# function vscode_puppet() {
# 	spushd
# 	cdp
# 	code -n .
# 	code -r puppet-control-repo/inventory.yaml
# 	spopd
# 	tab-reset
# }
# function vscode_nagios() {
# 	spushd
# 	cdnag
# 	code .
# 	spopd
# }

# alias vsp='vscode_puppet'
# alias vp='vscode_puppet'
# alias vsn='vscode_nagios'
# alias vsnotes='vscode_notes'
# alias vd='vscode_dotfiles'
