function spushd() {
    pushd "$1" >/dev/null || return
}
function spopd() {
    stack_depth=$(dirs -p | wc -l)
    if [ "$stack_depth" -gt 1 ]; then
        popd >/dev/null || return
    fi
}

function dir_jump() {
    search_dirs=(
        "$HOME/racs"
        "$HOME/code"
        "$HOME/aws"
        "$HOME/azure"
        "$HOME/puppet"
        "$HOME/work"
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

# todo/notes
# alias todo="vim_notes __todo.md"
# alias notes="vim_notes"
function vim_notes() {
    spushd .
    cd "$NOTESDIR" || return
    set_tmux_window_name "notes"
    if [ -z "$1" ]; then
        nvim .
    else
        nvim "$1"
    fi
    reset_tmux_window_name
    spopd
}

# copy file contents to clipboard
function cl() {
    pbcopy <"$1"
}

# search and cd with fzf
function vs() {
    cd "$HOME/code" &&
        cd "$(fd --max-depth 2 --type directory | fzf)" &&
        nvim .
}

# gnu sed for MacOS
if [[ -f $HOMEBREW_BINDIR/gsed ]]; then
    alias sed="gsed"
fi

function firefox() {
    if [ "$DOT_OS" = "mac" ]; then
        /Applications/Firefox.app/Contents/MacOS/firefox file://"$(pwd)"/"$1"
    fi
}

function edge() {
    if [ "$DOT_OS" = "mac" ]; then
        open -a Microsoft\ Edge "$1"
    fi
}

# clangd
insert_path "/usr/local/opt/llvm/bin"

# known_hosts_quick
known_hosts_remove() {
    if ! [[ $1 =~ [0-9]+ ]]; then
        echo "bad input $1"
    else
        gsed -i -e "$1d" "$HOME/.ssh/known_hosts"
    fi
}

# load keys
function ssh_load_keys() {
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/uoregon/id_rsa
    ssh-add ~/.ssh/github/id_rsa
}

# update alacritty app icon
function update_alacritty_icon() {
    icon_path=/Applications/Alacritty.app/Contents/Resources/alacritty.icns
    if [ ! -f "$icon_path" ]; then
        echo "Can't find existing icon, make sure Alacritty is installed"
        exit 1
    fi

    echo "Backing up existing icon"
    hash="$(shasum $icon_path | head -c 10)"
    mv "$icon_path" "$icon_path.backup-$hash"

    echo "Downloading replacement icon"
    icon_url=https://github.com/hmarr/dotfiles/files/8549877/alacritty.icns.gz
    curl -sL $icon_url | gunzip >"$icon_path"

    touch /Applications/Alacritty.app
    killall Finder
    killall Dock
}
