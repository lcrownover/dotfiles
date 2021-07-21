# make the swp dir
test -d ~/.backup || mkdir ~/.backup

# neovim
alias vim='nvim'

# clean swap
alias swap_clean=" rm -f $HOME/.local/share/nvim/swap/*.s*"
alias swap_cd=" cd $HOME/.local/share/nvim/swap/"
alias swap_list=" ls $HOME/.local/share/nvim/swap/*.s*"

# edit config
function navigate_and_edit_nvim_config() {
    cwd="$(pwd)"
    cd $HOME/.config/nvim
    nvim init.vim
    cd $cwd
}
alias vimc='navigate_and_edit_nvim_config'

# vim
function vim_puppet() {
    cwd="$(pwd)"
    cdp
    tab-color 250 173 33
    vim puppet-control-repo/inventory.yaml
    tab-reset
    cd $cwd
}
function vim_nagios() { cdnag; vim }

function vim_notes() {
    cwd="$(pwd)"
	cd ~/GoogleDrive/notes
	tab-color 255 0 255
	vim README.md
    tab-reset
    cd $cwd
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

