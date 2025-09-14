#!/bin/bash

if type kubectl >/dev/null 2>&1; then
    alias k=lazykubectl
fi

lazykubectl() {
    compdef __start_kubectl k
    source <(kubectl completion zsh)
    kubectl "$@"
}
