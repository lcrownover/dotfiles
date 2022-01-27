# make the swp dir
test -d ~/.backup || mkdir ~/.backup

# neovim
alias vim='nvim'

# shorter
function v() {
    if [ -z $1 ]; then
        nvim .
    else
        nvim $1
    fi
}


# clean swap
alias swap_clean=" rm -f $HOME/.local/share/nvim/swap/*.s*"
alias swap_cd=" cd $HOME/.local/share/nvim/swap/"
alias swap_list=" ls $HOME/.local/share/nvim/swap/*.s*"

# edit config
function navigate_and_edit_nvim_config() {
    pushd . > /dev/null
    cd $HOME/.config/nvim
    nvim init.vim
    popd > /dev/null
}
alias vimc='navigate_and_edit_nvim_config'
# edit dotfiles
function navigate_and_edit_dotfiles() {
    pushd . > /dev/null
    cd $DOTFILES
    nvim .
    popd > /dev/null
}
alias vimd='navigate_and_edit_dotfiles'

# vim
function vim_puppet() {
    # set_tmux_window_name "vip"
    cwd="$(pwd)"
    cdp
    tab-color 250 173 33
    vim puppet-control-repo/inventory.yaml
    tab-reset
    cd $cwd
    # set_tmux_window_name "zsh"
}
function vim_nagios() { cdnag; vim }

function vim_notes() {
    spushd .
	cd ~/$GDRIVEDIR/notes
    tab-color 0 170 170
	vim README.md
    tab-reset
    spopd
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

