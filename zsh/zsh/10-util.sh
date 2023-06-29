# z navigation
if [ "$OS" = "mac" ]; then
    . $HOME/code/repos/z/z.sh
fi

# todo/notes
# alias notes="code -n $NOTESDIR"
# alias todo="code -n $NOTESDIR; code -r $NOTESDIR/__todo.md"
alias todo="vim_notes __todo.md"
alias notes="vim_notes"
function vim_notes() {
    spushd .
    cd "$NOTESDIR"
    set_tmux_window_name "notes"
    nvim "$1"
    reset_tmux_window_name
    spopd
}

# copy file contents to clipboard
function cl() {
    cat $1 | pbcopy
}

# search and cd with fzf
function vs() {
    cd $HOME/code && \
    cd $(fd --max-depth 2 --type directory | fzf) && \
    nvim .
}

# gnu sed for MacOS
if [[ -f $HOMEBREW_BINDIR/gsed ]]; then
    alias sed="gsed"
fi

function firefox() {
    FF="/Applications/Firefox.app/Contents/MacOS/firefox"
    $FF file://"$(pwd)"/"$1"
}

# clangd
insert_path "/usr/local/opt/llvm/bin"

function spushd() { pushd "$1" > /dev/null }
function spopd() { popd > /dev/null }

# known_hosts_quick
known_hosts_remove() {
    if ! [[ $1 =~ "[0-9]+" ]]; then
        echo "bad input $1"
    else
        gsed -i -e "$1d" $HOME/.ssh/known_hosts
    fi
}

# load keys
function ssh_load_keys() {
    eval `ssh-agent -s`
    ssh-add ~/.ssh/uoregon/id_rsa
    ssh-add ~/.ssh/github/id_rsa
}

function rcode(){
    if [ "$#" = 1 ]; then
        RHOST=$(echo $1 | cut -d':' -f1)
        RPATH=$(echo $1 | cut -d':' -f2)
    elif [ "$#" = 2 ]; then
        RHOST=$1
        RPATH=$2
    else
        echo "usage:  rcode HOSTNAME PATH"
        return 1
    fi
    REMOTEPASS=$(rpw $RHOST)
    RDIR=$(echo $RPATH | sed 's/\//\_/g')
    LOCALMNTDIR="$HOME/mnt/$RHOST---$RDIR"
    mkdir -p $LOCALMNTDIR
    umount $LOCALMNTDIR 2>/dev/null
    sshfs -o ServerAliveInterval=15,ServerAliveCountMax=3,password_stdin root@$RHOST:$RPATH $LOCALMNTDIR <<< $REMOTEPASS
    code $LOCALMNTDIR
    # umount -l $LOCALMNTDIR
}
alias urcode="df -h | grep root@ | awk '{print \$NF}' | xargs umount"
