EITRI_HOSTNAME="is-lc-forge"

if [[ "$(hostname)" = "$EITRI_HOSTNAME" ]]; then
    eval `keychain --eval --quiet`
    if [[ -n "$TMUX" ]]; then
        (keychain -l | grep github >/dev/null 2>&1) || ssh-add ~/.ssh/github/id_rsa
        (keychain -l | grep uoregon >/dev/null 2>&1) || ssh-add ~/.ssh/uoregon/id_rsa
    fi
    export PATH="$PATH:/opt/node/bin"
    [[ ! -n "$TMUX" ]] && work
fi

function eitri() {
    if [[ -n "$TMUX" ]]; then
        echo "Nuh uh, not gonna nest tmux sessions. Detach from tmux first."
        return
    fi
    if [ "$(hostname)" = "$EITRI_HOSTNAME" ]; then
        echo "You're already on eitri."
        return
    fi
    source ~/dotfiles/eitri/eitri.env
    ssh -o StrictHostKeyChecking=no "$(curl -s -k https://sas-api.uoregon.edu/api/v1/lcrown/eitri -X GET -u "$EITRI_API_USERNAME:$EITRI_API_PASSWORD" | ~/dotfiles/eitri/ip_decode.py)" -q 2>/dev/null
}
