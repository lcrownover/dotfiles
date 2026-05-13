if command -v kubectl >/dev/null 2>&1; then
    kubectl() {
        unfunction kubectl
        source <(command kubectl completion zsh)
        kubectl "$@"
    }
    alias k=kubectl
fi
