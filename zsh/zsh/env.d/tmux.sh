alias tmux='tmux -2'
alias t='start_tmux_session_with_pwd_name'

start_tmux_session_with_pwd_name() {
    [[ -n "$TMUX" ]] || tmux new-session -s "$(pwd)" -n ''
}

set_tmux_window_name() {
    [[ -n "$TMUX" ]] || return
    if [[ "$1" == "" ]]; then
        tmux rename-window " $(basename $(pwd))"
    else
        tmux rename-window " $1"
    fi
}

reset_tmux_window_name() {
    DEFAULT_TMUX_WINDOW_NAME="zsh"
    [[ -n "$TMUX" ]] && tmux rename-window $DEFAULT_TMUX_WINDOW_NAME
}

main() {
    [[ -n "$TMUX" ]] && OP="switch" || OP="attach"
    tmux ls | grep -q main || tmux new-session -d -s main -n ''
    tmux -2 "$OP" -t main
    # tmux -2 new-session -A -s main
}

tmux_close_last_stay_open() {
    [[ -n "$TMUX" ]] || return

    CURRENT_TMUX_WINDOW_ID=$(tmux list-windows | grep '(active)' | awk '{print $1}' | cut -d':' -f1)
    CURRENT_TMUX_PANE_ID=$(tmux list-panes | grep '(active)' | awk '{print $1}' | cut -d':' -f1)

    # if there are more than one panes in the window, just kill the pane and exit early
    if [[ $(tmux list-panes -t "$CURRENT_TMUX_WINDOW_ID" | wc -l) -gt 1 ]]; then
        tmux kill-pane -t "$CURRENT_TMUX_PANE_ID"
        return
    fi
    # if this is the last window, create a new blank one
    if [[ $(tmux list-windows | wc -l) -eq 1 ]]; then
        tmux new-window -n ''
    fi
    # kill the current window
    tmux kill-window -t :"$CURRENT_TMUX_WINDOW_ID"
}

unmain() {
    tmux ls | grep -q main && tmux kill-session -t main
}

# split after 80 chars
code_split() {
    tmux split-window -h -l "$(echo "$(tput cols) 80 - p" | dc)"
}

settitle() {
    printf "\033k%s\033\\" "$1"
}
