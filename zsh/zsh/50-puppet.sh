# sourced from ~/.zshrc
#
# Puppet configurations
#
export BOLT=~/.puppetlabs/bolt
export PUPPET_BASE_DIR="$HOME/puppet/is"
export PATH="/opt/puppetlabs/bin/:$PATH"

alias boltfile="vim $HOME/.puppetlabs/bolt/Puppetfile"
alias cdb="cd $HOME/.puppetlabs/bolt"
alias bcr='bolt command run --stream --no-verbose'
alias cds="cd $HOME/repos/systems"
alias cdnag="cd $PUPPET_BASE_DIR/puppet-systems/nagios/"
alias cdey="cd $HOME/tools/eyaml"

# this is used by a lot of other funcs
function puppet_navigate_to_basedir() {
	if [ -z $1 ]; then
		tab-color 250 173 33; cd $PUPPET_BASE_DIR
	else
		tab-color 250 173 33; cd $PUPPET_BASE_DIR/puppet_$1
	fi
    echo ""
    echo ""
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
    for f in $(find $PUPPET_BASE_DIR/* -type d -maxdepth 0 -not -path ./.vscode); do
        echo "$(basename $f)"
    done
}

# returns the status of any puppet repos that have changes pending
function puppet_git_status_all() {
    tmp=~/temp/.gsapout
	cwd=$(pwd)
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
	cd $cwd
	[ "$1" = "long" ] && vim $tmp
	echo > $tmp
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
	cwd=$(pwd); puppet_navigate_to_basedir
	for pdir in $(puppet_list_puppet_directories); do
		if [ "$pdir" = "puppet-systems" ]; then
			continue
		fi
		cd $pdir
		git checkout -b "$1"
		puppet_navigate_to_basedir
	done
	cd $cwd
}

# merges the given branch to master on all puppet modules
function puppet_git_merge_to_master_all() {
    echo ""
	if [ "$1" = "" ]; then
		echo "gotta give me a branch name matching regex 'feature_.*' as \$1"
		return 1
	fi
	cwd=$(pwd); puppet_navigate_to_basedir
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
	cd $cwd
}

# provide a commit message and it will commit all changes on all modules with that message
function puppet_git_commit_all() {
	cwd=$(pwd)
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
	cd $cwd
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
		git pull --quiet
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
alias gcap='puppet_git_commit_and_push_all'

alias gprs='ssh is-puppetmaster.uoregon.edu "cd /etc/puppetlabs/fileserver-repos/puppet-systems; sudo git pull"'


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
