if [[ -n $TERM_PROGRAM ]] && [[ $TERM_PROGRAM = "iTerm.app" ]]; then
    export ITERM2_SQUELCH_MARK=1
    test -e "$HOME/.iterm2_shell_integration.zsh" && source "$HOME/.iterm2_shell_integration.zsh" || true
fi
