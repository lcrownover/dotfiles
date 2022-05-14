ANSIBLE_GALAXY_API_KEY="$(get_from_keepass 'Ansible Galaxy' 'api_key')"

alias ap='ansible-playbook'
alias ag='ansible-galaxy'
alias ave='ansible-vault encrypt'
alias avd='ansible-vault decrypt'
