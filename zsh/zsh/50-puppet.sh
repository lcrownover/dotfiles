# sourced from ~/.zshrc
#
# Puppet configurations
#
export BOLT=~/.puppetlabs/bolt
export PUPPET_BASE_DIR="$HOME/puppet/is"
insert_path "/opt/puppetlabs/bin/"
insert_path "$HOME/repos/puppet-editor-services/"

alias boltfile="nvim $HOME/.puppetlabs/bolt/Puppetfile"
alias cdb="cd $HOME/.puppetlabs/bolt"
alias bcr='bolt command run --stream --no-verbose'
alias cds="cd $HOME/repos/systems"
alias cdnag="cd $PUPPET_BASE_DIR/puppet-systems/nagios/"
alias cdey="cd $HOME/tools/eyaml"

# this is used by a lot of other funcs
function puppet_navigate_to_basedir() {
	if [ -z $1 ]; then
		cd $PUPPET_BASE_DIR
	else
		cd $PUPPET_BASE_DIR/puppet_$1
	fi
}

# puppet fileserver repos
function puppet_navigate_to_filesystem_repos() {
	if [ -z $1 ]; then
		cd ~/puppet/fileserver-repos
	else
		cd ~/puppet/fileserver-repos/puppet-$1
	fi
}

# outputs a list of all the dirs in the PUPPET_BASE_DIR
function puppet_list_puppet_directories() {
    for f in $(find $PUPPET_BASE_DIR/* -type d -maxdepth 0 | grep -v vscode | grep -v _mass_scripts); do
        echo "$(basename $f)"
    done
}

# returns the status of any puppet repos that have changes pending
function puppet_git_status_all() {
    tmp=~/temp/.gsapout
    spushd .
	puppet_navigate_to_basedir
	for pdir in $(puppet_list_puppet_directories); do
		cd $pdir
		if [[ $(git status --porcelain | wc -l) -gt 0 ]]; then
			if [ "$1" = "long" ]; then
				echo "[$(git rev-parse --abbrev-ref HEAD)] $pdir" | tee -a $tmp
				echo "$(git diff)\n\n" >> $tmp
			else
				echo "[$(git rev-parse --abbrev-ref HEAD)] $pdir"
                git status --porcelain
			fi
		fi
		cd ..
	done
    spopd
	[ "$1" = "long" ] && vim $tmp
	echo > $tmp
}

# shows each repo and its currently checked-out branch
function puppet_git_branch_all() {
    spushd .
	puppet_navigate_to_basedir
	for pdir in $(puppet_list_puppet_directories); do
		cd $pdir
        echo "[$(git rev-parse --abbrev-ref HEAD)] $pdir"
		cd ..
	done
    spopd
}

# writes all pending changes to a tempfile and opens an editor at that file
function puppet_git_status_all_long() {
	puppet_git_status_all long
}

# checks out the given branch on all puppet modules
function puppet_git_checkout_branch_all() {
	if [ "$1" = "" ]; then
		echo "gotta give me a branch name matching regex 'feature_.*' as \$1"
		return 1
	fi
    spushd .
    puppet_navigate_to_basedir
	for pdir in $(puppet_list_puppet_directories); do
		if [ "$pdir" = "puppet-systems" ]; then
			continue
		fi
		cd $pdir
		git checkout -b "$1"
		puppet_navigate_to_basedir
	done
    spopd
}

# merges the given branch to master on all puppet modules
function puppet_git_merge_to_master_all() {
	if [ "$1" = "" ]; then
		echo "gotta give me a branch name matching regex 'feature_.*' as \$1"
		return 1
	fi
    spushd .
    puppet_navigate_to_basedir
	for pdir in $(puppet_list_puppet_directories); do
		if [ "$pdir" = "puppet-systems" ]; then
			continue
		fi
		cd $pdir
		git checkout master
		git pull
		git merge --no-edit "$1" && git push && git push origin :$1 && git branch -d $1
		puppet_navigate_to_basedir
	done
    spopd
}

# provide a commit message and it will commit all changes on all modules with that message
function puppet_git_commit_all() {
    spushd .
	puppet_navigate_to_basedir
	for pdir in $(puppet_list_puppet_directories); do
		if [ "$pdir" = "puppet-systems" ]; then
			continue
		fi
		cd $pdir
		if [[ $(git status --porcelain | wc -l) -gt 0 ]]; then
			echo "[$(git rev-parse --abbrev-ref HEAD)] $pdir => \"$1\""
			git add --all
			git commit -m "$1"
		fi
		if [ "$2" = "push" ]; then
			[[ $(git status --branch --porcelain | grep ahead) ]] && git push origin $(git rev-parse --abbrev-ref HEAD)
		fi
		cd ..
	done
    spopd
}

function git_log_file() {
    filename="$1"
    pdir="$(echo $filename | cut -d'/' -f1)"
    fpath="$(echo $filename | sed "s/$pdir\///")"
    git --git-dir "$pdir/.git" log -p --reverse -- "$fpath"
}


# provide a commit message and it will commit and push all changes on all modules with that message
function puppet_git_commit_and_push_all() {
	puppet_git_commit_all $1 push
}

# pull all puppet modules
function puppet_pull_all() {
	cwd=$(pwd)
	puppet_navigate_to_basedir
	for pdir in $(puppet_list_puppet_directories); do
		cd $pdir
        [ "$1" = "master" ] && git checkout master --quiet
        echo "[$(git branch --show-current)] $pdir"
		git pull origin $(git rev-parse --abbrev-ref HEAD) --quiet
		cd ..
	done
	cd $cwd
}

# navigate to control-repo or puppet-systems
function cdpc() { tab-color 250 173 33; cd $PUPPET_BASE_DIR/puppet-control-repo }
function cdps() { tab-color 250 173 33; cd $PUPPET_BASE_DIR/puppet-systems }


# aliases to provide shortened names for usability
alias cdp='puppet_navigate_to_basedir'
alias cdfs='puppet_navigate_to_filesystem_repos'

alias gpa='puppet_pull_all'
alias gsa='puppet_git_status_all'
alias gsal='puppet_git_status_all_long'
alias gca='puppet_git_commit_all'
alias gba='puppet_git_branch_all'
alias gcap='puppet_git_commit_and_push_all'

alias gprs='ssh is-puppetmaster.uoregon.edu "cd /etc/puppetlabs/fileserver-repos/puppet-systems; sudo git pull"'

alias glf='git_log_file'

# puppetserver node purge
function puppet_node_purge() {
	for arg in $@; do
		if [[ $arg == "-y" ]]; then
			confirm=1
		fi
	done
	if [[ $confirm -ne 1 ]]; then
		echo "Purging nodes:"
		for i in $@; do echo "  $i"; done
		echo -n "Are you sure? (y/n): "
		read REPLY
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			for arg in $@; do
				ssh is-puppetmaster sudo puppet node purge $arg
			done
		fi
	fi
}

function bs() {
	case "$1" in
	t*)
		vim ~/.bolt-targets.txt
		;;
	e*)
		vim ~/.bolt-script.sh
		;;
	r*)
		bolt script run ~/.bolt-script.sh --targets @~/.bolt-targets.txt --transport pcp
		;;
	*)
		echo "usage:  bs (e|t|r)"
		echo "	e : edit script"
		echo "	t : edit targets"
		echo "	r : run script against targets"
		;;
	esac
}

function noop() {
	if [[ $2 == "s" ]]; then
		bolt command run "bash -c /usr/local/sbin/puppet_noop_${1}.sh" --targets
	else
		bolt command run "bash -c /usr/local/sbin/puppet_noop_${1}.sh" --targets $2
	fi
}

function pat() {
	c="puppet agent --test"
	[[ ! -z $2 ]] && c+=" --environment $2"
	bolt command run $c --targets $1 --stream --no-verbose
}

function vim_puppet() {
    spushd .
    cdp
    set_tmux_window_name "puppet"
    nvim puppet-control-repo/inventory.yaml
    reset_tmux_window_name
    spopd
}
function vim_nagios() { cdnag; vim }

alias vip='vim_puppet'
alias vin='vim_nagios'
