if [[ "$(hostname)" = "is-lc-forge" ]]; then
    eval `keychain --eval --quiet`
    if [[ -n "$TMUX" ]]; then
        (keychain -l | grep github >/dev/null 2>&1) || ssh-add ~/.ssh/github/id_rsa
        (keychain -l | grep uoregon >/dev/null 2>&1) || ssh-add ~/.ssh/uoregon/id_rsa
    fi
fi



