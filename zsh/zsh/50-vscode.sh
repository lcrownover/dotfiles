# vscode
alias vs='code'
alias c='code'

# vscode
function vscode_puppet() {
	spushd
	cdp
	code -n .
	# code -r puppet-control-repo/inventory.yaml
	spopd
	tab-reset
}
function vscode_nagios() {
	spushd
	cdnag
	code .
	spopd
}
function vscode_notes() {
	spushd
	cd "$NOTESDIR"
	code .
}
function vscode_dotfiles() {
	spushd
	cd $DOTFILES
	code .
	spopd
}

alias vsp='vscode_puppet'
alias vp='vscode_puppet'
alias vsn='vscode_nagios'
alias vsnotes='vscode_notes'
alias vd='vscode_dotfiles'
