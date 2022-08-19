tssh() {
    TERM=screen-256color \ssh "$@"
}
alias ssh='tssh'

dev() {
    if [[ $# -lt 1 ]]; then
        ssh is-lc-dev.uoregon.edu
    else
        ssh -t is-lc-dev.uoregon.edu "$@; bash"
    fi
}

# this function re-links all the ssh configs from keepass where the keys are stored
function ensure_ssh_keys() {
    mkdir -p $HOME/.ssh/keys

    # uoregon
    d="$HOME/.ssh/keys/uoregon"
    mkdir -p $d
    printf "$(get_from_keepass 'uoregon' 'private_key')" > "$d/id_rsa"
    printf "$(get_from_keepass 'uoregon' 'public_key')" > "$d/id_rsa.pub"
    chmod 600 "$d/id_rsa"

    # github
    d="$HOME/.ssh/keys/github"
    mkdir -p $d
    printf "$(get_from_keepass 'Github' 'private_key')" > "$d/id_rsa"
    chmod 600 "$d/id_rsa"

    # aws-personal
    d="$HOME/.ssh/keys/aws-personal"
    mkdir -p $d
    printf "$(get_from_keepass 'AWS - lcrownover127@gmail.com' 'private_key')" > "$d/id_rsa"
    chmod 600 "$d/id_rsa"

    # talapas
    d="$HOME/.ssh/keys/talapas"
    mkdir -p $d
    printf "$(get_from_keepass 'talapas - HPC' 'private_key')" > "$d/id_rsa"
    printf "$(get_from_keepass 'talapas - HPC' 'public_key')" > "$d/id_rsa.pub"
    chmod 600 "$d/id_rsa"
}
