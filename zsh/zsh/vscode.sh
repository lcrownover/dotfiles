# vscode
alias vs='code .'
alias code='code -n .'

# vscode
function vscode_puppet() {
	CWD=$(pwd)
	cdp
	code .
	cd $CWD
	tab-reset
	exit
}
function vscode_nagios() {
	CWD=$(pwd)
	cdnag
	code .
	cd $CWD
}
function vscode_notes() {
	CWD=$(pwd)
	cd ~/GoogleDrive/notes
	code .
	exit
}

alias vp='vscode_puppet'
alias vn='vscode_nagios'
alias notes='vscode_notes'
