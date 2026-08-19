# history with ctrl-r using fzf
source <(fzf --zsh)

alias ls="eza"
alias ll="eza -l"
alias la="eza -la"

spushd() {
    pushd "$1" >/dev/null || return
}
spopd() {
    stack_depth=$(dirs -p | wc -l)
    if [ "$stack_depth" -gt 1 ]; then
        popd >/dev/null || return
    fi
}

insert_path() {
    [ -z "$TMUX" ] && LVL=1 || LVL=2
    [ "$SHLVL" -eq "$LVL" ] && export PATH="$1:$PATH"
}
append_path() {
    [ -z "$TMUX" ] && LVL=1 || LVL=2
    [ "$SHLVL" -eq "$LVL" ] && export PATH="$PATH:$1"
}

dir_jump() {
    search_dirs=(
        "$HOME/racs"
        "$HOME/code"
        "$HOME/aws"
        "$HOME/azure"
        "$HOME/puppet"
        "$HOME/work"
        "$HOME/work/cloud"
        "$HOME/work/cloud/aws"
    )
    max_depth=3
    case "$1" in
    racs*)
        cd "$HOME/racs/racs-ansible" || return
        return
        ;;
    doc*)
        cd "$HOME/racs/racs-internal-docs" || return
        return
        ;;
    dot*)
        cd "$HOME/.dotfiles" || return
        return
        ;;
    sch*)
        cd "$HOME/Google Drive/My Drive/school" || return
        return
        ;;
    aws*)
        search_dirs=("$HOME/work/cloud/aws/uo-cloud-infra/")
        max_depth=1
        ;;
    esac
    cd "$(fd \
        --max-depth "${max_depth}" \
        --type directory . "${search_dirs[@]}" |
        fzf --query="$1")" || return
}
alias j="dir_jump"

# copy file contents to clipboard
clip() {
    pbcopy <"$1"
}

# gnu sed for macOS
if [[ -f $HOMEBREW_BINDIR/gsed ]]; then
    alias sed="gsed"
fi

firefox() {
    if [ "$DOT_OS" = "mac" ]; then
        /Applications/Firefox.app/Contents/MacOS/firefox file://"$(pwd)"/"$1"
    fi
}

edge() {
    if [ "$DOT_OS" = "mac" ]; then
        open -a Microsoft\ Edge "$1"
    fi
}

excel() {
    if [ "$DOT_OS" = "mac" ]; then
        open -a Microsoft\ Excel "$1"
    fi
}

# load keys
ssh_load_keys() {
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/uoregon/id_rsa
    ssh-add ~/.ssh/github/id_rsa
}
