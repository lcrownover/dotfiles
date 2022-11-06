if [[ -f $HOMEBREW_BINDIR/kubectl ]]; then
    alias k=kubectl
    alias kns="kubectl config set-context --current --namespace"
fi
