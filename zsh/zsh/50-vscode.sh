# vscode
alias vs='code -n'
alias code='code -n'
alias c='code -n'

# vscode
function vscode_puppet() {
	spushd
	cdp
    code -n .
	code -r puppet-control-repo/inventory.yaml
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
	cd ~/$GDRIVEDIR/notes
	code .
}

alias vsp='vscode_puppet'
alias vp='vscode_puppet'
alias vsn='vscode_nagios'
alias vsnotes='vscode_notes'
