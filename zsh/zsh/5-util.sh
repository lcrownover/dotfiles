# openfortivpn
function vpn() {
    tmux new-session -s "openfortivpn" -n "vpn" -d
    tmux send-keys -t "openfortivpn:vpn" "sudo openfortivpn -c $HOME/dotfiles/openfortivpn/my-conf" C-m
    tmux switch -t "openfortivpn:vpn"
}

# todo
function todo() {
    tab-color 0 170 170
    nvim ~/.todo.md
    tab-reset
}

# hostfmt
alias hostfmt="$GDRIVEDIR/code/projects/hostfmt.py"

# shorter clear
alias cl="clear"

# ssh function that will do window naming
function ssh() {
    set_tmux_window_name "$1"
    command ssh "$@"
    set_tmux_window_name "zsh"
}

# clangd
export PATH="/usr/local/opt/llvm/bin:$PATH"

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
[ -d $REXPANDPATH ] && export PATH="$REXPANDPATH:$PATH" && alias rex='rexpand'

# locations and files
function gps() { CWD=$(pwd); cd $HOME/repos/systems; git pull; cd $CWD }

export S='~/.servers.txt'

# workflows
function cred() { /usr/bin/env python3 $GDRIVEDIR/code/scripts/workflows/cred.py $1 | pbcopy }

# python
alias venv='source ./venv/bin/activate'

function pyclean () {
        find . -type f -name "*.py[co]" -delete
        find . -type d -name "__pycache__" -delete
}

# ping everything in servers.txt
function mping() {
	for host in $(cat $HOME/.servers.txt); do
    		ping -c2 "$host" &>/dev/null && printf "success -- " || printf "fail -- "
		echo "$host"
	done
}

function vvssh(){
	title $1
	ssh $1 -t 'screen -h 2000 -dRR -S lcrown'
}

function pushdns(){
	bolt command run --targets is-nsdb1 "puppet agent --test"
	bolt command run --targets phloem "puppet agent --test"
}

function rpw(){
	SYS_REPO=$HOME/repos/systems
	CREDF=$HOME/.credentials.yaml
	HOSTNAME=$1
	GROUP=$2
	if [ "$GROUP" = "ids" ]; then
		KEY=$(grep ids_seed: $CREDF | awk -F"\'" '{print $2}')
	else
		KEY=$(grep sys_seed: $CREDF | awk -F"\'" '{print $2}')
	fi
	ruby $SYS_REPO/root_password/generator/root_password_generator.rb --hostname $HOSTNAME --key $KEY | tail -n 1 | tr -d '\n'
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
	LOCALMNTDIR="/Users/$(whoami)/mnt/$RHOST---$RDIR"
	mkdir -p $LOCALMNTDIR
	umount $LOCALMNTDIR 2>/dev/null
	sshfs -o ServerAliveInterval=15,ServerAliveCountMax=3,password_stdin root@$RHOST:$RPATH $LOCALMNTDIR <<< $REMOTEPASS
	code $LOCALMNTDIR
	# umount -l $LOCALMNTDIR
}
alias urcode="df -h | grep root@ | awk '{print \$NF}' | xargs umount"
