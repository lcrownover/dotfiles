# z navigation
if [ "$DOT_OS" = "mac" ]; then
	source $HOME/code/repos/z/z.sh
fi

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
	case "$1" in
	racs*)
		cd ~/code/racs-ansible || return
		;;
	dot*)
		cd ~/.dotfiles || return
		;;
	*)
		cd "$(fd --max-depth 3 --type directory . ~/code | fzf --query="$1")" || return
		;;
	esac
}
alias j="dir_jump"

# todo/notes
alias todo="vim_notes __todo.md"
alias notes="vim_notes"
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
