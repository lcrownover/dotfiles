function set_tmux_window_name() {
    [[ -n "$TMUX" ]] && tmux rename-window "$1"
}

function work() {
    session="work"
    tmux new-session -d -s $session

    tmux rename-window -t $session:1 "todo"
    tmux send-keys -t "todo" "todo" C-m

    tmux new-window -t $session:2 -n "vip"
    tmux send-keys -t "vip" "vip" C-m

    tmux new-window -t $session:3 -n "zsh"

    tmux attach -t $session:3
}
