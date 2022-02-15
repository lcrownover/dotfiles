# openfortivpn
function vpn() {
    VPNCONF="$HOME/.config/openfortivpn/openfortivpn.conf"
    VPNCMD="cd ~; sudo openfortivpn -c $VPNCONF --otp push"
    tmux list-sessions | grep openfortivpn >/dev/null || tmux new-session -s "openfortivpn" -n "vpn" -d
    ps ax | grep -v grep | grep -s 'sudo openfortivpn -c'
    if [ $? -eq 1 ]; then
        tmux send-keys -t "openfortivpn:vpn" "$VPNCMD" C-m
    fi
}

# z navigation
. /opt/homebrew/etc/profile.d/z.sh

# todo
# alias todo="code -n $HOME/$ONEDRIVEDIR/notes; code -r $HOME/$ONEDRIVEDIR/notes/__todo.md"
alias todo="vim_todo"
function vim_todo() {
    spushd .
	cd "$NOTESDIR"
    # tab-color 0 170 170
	nvim __todo.md
    # tab-reset
    spopd
}
function tmux_todo() {
    session="todo"
    [[ -n $TMUX ]] && OP="switch" || OP="attach"
    $(tmux ls | grep -q $session) || tmux new-session -d -s $session
    tmux $OP -t $session
    # tmux send-keys -t "$session:1" "vim_todo" C-m
}

# hostfmt
alias hostfmt="$GDRIVEDIR/code/projects/hostfmt.py"

# pj
insert_path "$HOME/repos/pj/bin"

# shorter clear
alias cl="clear"


function firefox() {
    FF="/Applications/Firefox.app/Contents/MacOS/firefox"
    $FF file://"$(pwd)"/"$1"
}

# ssh function that will do window naming
function ssh() {
    set_tmux_window_name "$1"
    command ssh "$@"
    set_tmux_window_name "zsh"
}

# clangd
insert_path "/usr/local/opt/llvm/bin"

function spushd() { pushd "$1" > /dev/null }
function spopd() { popd > /dev/null }

# known_hosts_quick
function known_hosts_remove() {
	if ! [[ $1 =~ "[0-9]+" ]]; then
		echo "bad input $1"
	else
		sed -i "" "$1d" $HOME/.ssh/known_hosts
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
