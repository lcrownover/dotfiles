if [[ "$(hostname)" = "is-lc-forge" ]]; then
    if [[ ! -n "$TMUX" ]]; then work; fi
    eval `keychain --eval --quiet`
    if [[ -n "$TMUX" ]]; then
        (keychain -l | grep github >/dev/null 2>&1) || ssh-add ~/.ssh/github/id_rsa
        (keychain -l | grep uoregon >/dev/null 2>&1) || ssh-add ~/.ssh/uoregon/id_rsa
    fi
fi

function eitri() {
    source ~/dotfiles/eitri/eitri.env
    ssh "$(curl -k https://sas-api.uoregon.edu/api/v1/lcrown/eitri -X GET -u "$EITRI_API_USERNAME:$EITRI_API_PASSWORD" | ~/dotfiles/eitri/ip_decode.py)"
}
