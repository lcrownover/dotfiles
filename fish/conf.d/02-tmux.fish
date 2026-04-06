set -x DISABLE_AUTO_TITLE true

alias tmux 'tmux -2'
alias t 'start_tmux_session_with_pwd_name'

# TMUX gets set in VSCode for some reason
# so we can't use the default TMUX
if test -z "$TMUX"
    set -g VTMUX ""
else
    if tmux ls 2>&1 | grep -q 'no server running'
        set -g VTMUX ""
    else
        set -g VTMUX "$TMUX"
    end
end

function start_tmux_session_with_pwd_name
    if test -z "$VTMUX"
        tmux new-session -s (pwd)
    end
end

function set_tmux_window_name
    if test -n "$VTMUX"
        tmux rename-window $argv[1]
    end
end

function reset_tmux_window_name
    set default_tmux_window_name fish
    if test -n "$VTMUX"
        tmux rename-window $default_tmux_window_name
    end
end

function tmux_close_last_stay_open
    # dont do anything if not tmux
    test -n "$VTMUX"; or return

    set current_tmux_window_id (tmux list-windows | grep '(active)' | awk '{print $1}' | cut -d':' -f1)
    set current_tmux_pane_id (tmux list-panes | grep '(active)' | awk '{print $1}' | cut -d':' -f1)

    # if there are more than one panes in the window, just kill the pane and exit early
    if test (tmux list-panes -t "$current_tmux_window_id" | wc -l) -gt 1
        tmux kill-pane -t "$current_tmux_pane_id"
        return
    end
    # if this is the last window, create a new blank one
    if test (tmux list-windows | wc -l) -eq 1
        tmux new-window -n ''
    end
    # kill the current window
    tmux kill-window -t :"$current_tmux_window_id"
end

function unmain
    if tmux ls | grep -q main
        tmux kill-session -t main
    end
end

# split after 80 chars
function code_split
    tmux split-window -h -l (echo (tput cols) 80 - p | dc)
end

function settitle
    printf "\033k%s\033\\" $argv[1]
end

# Auto-attach to tmux main session based on terminal type
function main
    if test -n "$VTMUX"
        set op switch
    else
        set op attach
    end
    tmux ls | grep -q main; or tmux new-session -d -s main -n ''
    tmux -2 $op -t main
end
if test -z "$TMUX"
    if test "$DOT_OS" = wsl
        tmux new-session -A -s main -n ''
    else if test "$TERM" = xterm-kitty
        tmux new-session -A -s main -n ''
    else if test "$TERM_PROGRAM" = ghostty
        tmux new-session -A -s main -n ''
    # iTerm.app, vscode, WezTerm: no auto-attach
    end
end
