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

