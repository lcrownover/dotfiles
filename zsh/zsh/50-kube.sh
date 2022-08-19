if [[ -f /opt/homebrew/bin/kubectl ]]; then
    alias k=kubectl
    alias kns="kubectl config set-context --current --namespace"
fi
