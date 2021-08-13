function set_tmux_window_name() {
    [[ -n "$TMUX" ]] && tmux rename-window "$1"
}

function work() {
    session="work"

    if $(tmux ls | grep -q work); then
        tmux a -t work

    else
        tmux new-session -d -s $session

        tmux rename-window -t $session:1 "todo"
        tmux send-keys -t "todo" "todo" C-m

        tmux new-window -t $session:2 -n "puppet"
        tmux send-keys -t "puppet" "vip" C-m

        tmux new-window -t $session:3 -n "zsh"

        tmux attach -t "$session:zsh"
    fi
}
