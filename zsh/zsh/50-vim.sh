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
    spushd
    cd $HOME/.config/nvim
    nvim init.vim
    spopd
}
alias vimc='navigate_and_edit_nvim_config'

# edit dotfiles
function navigate_and_edit_dotfiles() {
    spushd
    cd $DOTFILES
    nvim .
    spopd
}
alias vimd='navigate_and_edit_dotfiles'
