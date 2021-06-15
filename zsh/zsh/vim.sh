# neovim
alias vim='nvim'
alias pvim='cd ~/puppet/is; nvim'

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
