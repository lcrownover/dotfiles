#!/bin/bash

# this function re-links all the ssh configs from keepass where the keys are stored
# this hasnt been maintained so i doubt it actually works enough.
function ensure_ssh_keys() {
    mkdir -p "$HOME/.ssh/keys"

    # uoregon
    d="$HOME/.ssh/keys/uoregon"
    mkdir -p "$d"
    printf "%s" "$(get_from_keepass 'uoregon' 'private_key')" >"$d/id_rsa"
    printf "%s" "$(get_from_keepass 'uoregon' 'public_key')" >"$d/id_rsa.pub"
    chmod 600 "$d/id_rsa"

    # github
    d="$HOME/.ssh/keys/github"
    mkdir -p "$d"
    printf "%s" "$(get_from_keepass 'Github' 'private_key')" >"$d/id_rsa"
    chmod 600 "$d/id_rsa"

    # aws-personal
    d="$HOME/.ssh/keys/aws-personal"
    mkdir -p "$d"
    printf "%s" "$(get_from_keepass 'AWS - lcrownover127@gmail.com' 'private_key')" >"$d/id_rsa"
    chmod 600 "$d/id_rsa"

    # talapas
    d="$HOME/.ssh/keys/talapas"
    mkdir -p "$d"
    printf "%s" "$(get_from_keepass 'talapas - HPC' 'private_key')" >"$d/id_rsa"
    printf "%s" "$(get_from_keepass 'talapas - HPC' 'public_key')" >"$d/id_rsa.pub"
    chmod 600 "$d/id_rsa"
}
