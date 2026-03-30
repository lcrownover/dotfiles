function ensure_ssh_keys
    mkdir -p "$HOME/.ssh/keys"

    # uoregon
    set d "$HOME/.ssh/keys/uoregon"
    mkdir -p "$d"
    printf "%s" (get_from_bitwarden 'uoregon' 'private_key') > "$d/id_rsa"
    printf "%s" (get_from_bitwarden 'uoregon' 'public_key') > "$d/id_rsa.pub"
    chmod 600 "$d/id_rsa"

    # github
    set d "$HOME/.ssh/keys/github"
    mkdir -p "$d"
    printf "%s" (get_from_bitwarden 'Github' 'private_key') > "$d/id_rsa"
    chmod 600 "$d/id_rsa"

    # aws-personal
    set d "$HOME/.ssh/keys/aws-personal"
    mkdir -p "$d"
    printf "%s" (get_from_bitwarden 'AWS - lcrownover127@gmail.com' 'private_key') > "$d/id_rsa"
    chmod 600 "$d/id_rsa"

    # talapas
    set d "$HOME/.ssh/keys/talapas"
    mkdir -p "$d"
    printf "%s" (get_from_bitwarden 'talapas - HPC' 'private_key') > "$d/id_rsa"
    printf "%s" (get_from_bitwarden 'talapas - HPC' 'public_key') > "$d/id_rsa.pub"
    chmod 600 "$d/id_rsa"
end
