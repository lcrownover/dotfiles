function set_tmux_window_name() {
    [[ -n "$TMUX" ]] && tmux rename-window "$1"
}
