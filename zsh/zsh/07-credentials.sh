# various credentials gotten from keepass

if [ "$OS" = "mac" ]; then
    export GITHUB_TOKEN="$(get_from_keepass 'Github' 'token -- lcrown')"
    export ANSIBLE_GALAXY_API_KEY="$(get_from_keepass 'Ansible Galaxy' 'api_key')"
fi
