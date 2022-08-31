# openconnect vpn
vpn() {
    case "$1" in
        "kill")
            OP="kill"
            ;;
        *)
            TOKEN="$1"
            ;;
    esac

    SUDOCMD="echo \$(get_from_keepass 'mac') | sudo -S true"

    if [ "$OP" = "kill" ]; then
        unset OP
        eval $SUDOCMD
        PID="$(ps ax | grep -v grep | grep 'sudo openconnect --config' | awk '{print $1}')"
        if [[ $PID ]]; then
            sudo kill $PID
        fi
        unset PID
        (tmux list-sessions | grep -q openconnect) && tmux kill-session -t openconnect
        return
    fi

    if [ -z "$TOKEN" ]; then
        TOKEN=push
    fi

    VPNCONF="$HOME/.config/openconnect/openconnect.conf"
    VPNCMD="cd ~; (echo \$(get_from_keepass 'uoregon'); echo $TOKEN) | sudo openconnect --config=$VPNCONF --passwd-on-stdin"

    tmux list-sessions | grep -q openconnect || tmux new-session -s "openconnect" -n "vpn" -d
    ps ax | grep -v grep | grep -q 'openconnect --config'
    if [ $? -eq 1 ]; then
        tmux send-keys -t "openconnect:vpn" "$SUDOCMD" Enter
        tmux send-keys -t "openconnect:vpn" "$VPNCMD" Enter
    fi
    unset TOKEN
}


# z navigation
if [ "$OS" = "mac" ]; then
    . /opt/homebrew/etc/profile.d/z.sh
fi

# todo/notes
# alias todo="code -n $HOME/$ONEDRIVEDIR/notes; code -r $HOME/$ONEDRIVEDIR/notes/__todo.md"
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

# hostfmt
alias hostfmt="$GDRIVEDIR/code/projects/hostfmt.py"

# pj
insert_path "$HOME/repos/pj/bin"

# copy file contents to clipboard
function cl() {
    cat $1 | pbcopy
}

# gnu sed for MacOS
if [[ -f /opt/homebrew/bin/gsed ]]; then
    alias sed="gsed"
fi


function firefox() {
    FF="/Applications/Firefox.app/Contents/MacOS/firefox"
    $FF file://"$(pwd)"/"$1"
}

# ssh function that will do window naming
# ssh() {
#     set_tmux_window_name "$1"
#     command ssh "$@"
#     reset_tmux_window_name
# }

# clangd
insert_path "/usr/local/opt/llvm/bin"

function spushd() { pushd "$1" > /dev/null }
function spopd() { popd > /dev/null }

# known_hosts_quick
known_hosts_remove() {
    if ! [[ $1 =~ "[0-9]+" ]]; then
        echo "bad input $1"
    else
        sed -i -e "$1d" $HOME/.ssh/known_hosts
    fi
}

# load keys
function ssh_load_keys() {
    eval `ssh-agent -s`
    ssh-add ~/.ssh/uoregon/id_rsa
    ssh-add ~/.ssh/github/id_rsa
}

# rexpand tool
REXPANDPATH="$GDRIVEDIR/code/scripts/rexpand/dist/rexpand/"
[ -d $REXPANDPATH ] && insert_path "$REXPANDPATH" && alias rex='rexpand'

# locations and files
function gps() { CWD=$(pwd); cd $HOME/repos/systems; git pull; cd $CWD }

# export S='~/.servers.txt'

# python
# function venv() {
# if [ "$1" = "new" ]; then python3 -m venv venv; fi
# source ./venv/bin/activate
# }

function pyclean () {
    find . -type f -name "*.py[co]" -delete
    find . -type d -name "__pycache__" -delete
}

# ping everything in servers.txt
# function mping() {
# for host in $(cat $HOME/.servers.txt); do
# ping -c2 "$host" &>/dev/null && printf "success -- " || printf "fail -- "
# echo "$host"
# done
# }

# function vvssh(){
# title $1
# ssh $1 -t 'screen -h 2000 -dRR -S lcrown'
# }

function pushdns(){
    bolt command run --targets is-nsdb1 "puppet agent --test"
    bolt command run --targets phloem "puppet agent --test"
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

alias a="fc -e -"
