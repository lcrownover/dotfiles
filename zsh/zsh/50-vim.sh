# make the swp dir
test -d ~/.backup || mkdir ~/.backup

# neovim
alias vim='nvim'

# vim
function vim_puppet() { cdp; vim }
function vim_nagios() { cdnag; vim }

function vim_notes() {
	cd ~/GoogleDrive/notes
	tab-color 255 0 255
	vim
}

alias vip='vim_puppet'
alias vin='vim_nagios'
alias vnotes='vim_notes'
alias notes='vim_notes'

function git_log_file() {
    filename="$1"
    pdir="$(echo $filename | cut -d'/' -f1)"
    fpath="$(echo $filename | sed "s/$pdir\///")"
    git --git-dir "$pdir/.git" log -p --reverse -- "$fpath"
}
alias glf='git_log_file'

