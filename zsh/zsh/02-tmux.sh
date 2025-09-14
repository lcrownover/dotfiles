#!/bin/bash

alias tmux='tmux -2'
alias t='start_tmux_session_with_pwd_name'

# TMUX gets set in VSCode for some reason
# so we can't use the default TMUX
case "$TMUX" in
"")
    VTMUX=""
    ;;
*)
    $(tmux ls 2>&1 | grep -q 'no server running')
    if [ $? -eq 0 ]; then
        VTMUX=""
    else
        VTMUX="$TMUX"
    fi
    ;;
esac

function start_tmux_session_with_pwd_name() {
    [[ -n $VTMUX ]] || tmux new-session -s "$(pwd)"
}

function set_tmux_window_name() {
    [[ -n $VTMUX ]] && tmux rename-window "$1"
}

function reset_tmux_window_name() {
    DEFAULT_TMUX_WINDOW_NAME="zsh"
    [[ -n $VTMUX ]] && tmux rename-window $DEFAULT_TMUX_WINDOW_NAME
}

function main() {
    [[ -n "$VTMUX" ]] && OP="switch" || OP="attach"
    tmux ls | grep -q main || tmux new-session -d -s main
    tmux -2 "$OP" -t main
    # tmux -2 new-session -A -s main
}

function tmux_close_last_stay_open() {
    # dont do anything if not tmux
    [[ -n $VTMUX ]] || return

    CURRENT_TMUX_WINDOW_ID=$(tmux list-windows | grep '(active)' | awk '{print $1}' | cut -d':' -f1)
    CURRENT_TMUX_PANE_ID=$(tmux list-panes | grep '(active)' | awk '{print $1}' | cut -d':' -f1)

    # if there are more than one panes in the window, just kill the pane and exit early
    if [[ $(tmux list-panes -t "$CURRENT_TMUX_WINDOW_ID" | wc -l) -gt 1 ]]; then
        tmux kill-pane -t "$CURRENT_TMUX_PANE_ID"
        return
    fi
    # if this is the last window, create a new blank one
    if [[ $(tmux list-windows | wc -l) -eq 1 ]]; then
        tmux new-window
    fi
    # kill the current window
    tmux kill-window -t :"$CURRENT_TMUX_WINDOW_ID"
}

function unmain() {
    tmux ls | grep -q main && tmux kill-session -t main
}

# split after 80 chars
function code_split() {
    tmux split-window -h -l "$(echo "$(tput cols) 80 - p" | dc)"
}

function settitle() {
    printf "\033k%s\033\\" "$1"
}
