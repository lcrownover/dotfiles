if [ "$OS" = "mac" ]; then
    export DOCKER_HOST="unix://$HOME/.local/share/containers/podman/machine/podman-machine-default/podman.sock"
    alias docker='podman'
    source <(podman completion zsh)
fi
