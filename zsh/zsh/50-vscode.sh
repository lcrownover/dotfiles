# vscode
alias vs='code -n'
alias code='code -n'

# vscode
function vscode_puppet() {
	spushd
	cdp
	code puppet-control-repo/inventory.yaml
	spopd
	tab-reset
	exit
}
function vscode_nagios() {
	spushd
	cdnag
	code .
	spopd
}
function vscode_notes() {
	spushd
	cd ~/GoogleDrive/notes
	code .
	exit
}

alias vsp='vscode_puppet'
alias vsn='vscode_nagios'
alias vsnotes='vscode_notes'
