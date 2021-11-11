function set_tmux_window_name() {
    [[ -n "$TMUX" ]] && tmux rename-window "$1"
}

function work() {
    [[ -n $TMUX ]] && OP="switch" || OP="attach"
    echo $OP
    if ! $(tmux ls | grep -q work); then
        echo "new session!"
        tmux new-session -d -s work
#         tmux rename-window -t $session:1 "todo"
#         tmux send-keys -t "todo" "todo" C-m
#         tmux new-window -t $session:2 -n "puppet"
#         tmux send-keys -t "puppet" "vip" C-m
#         tmux new-window -t $session:3 -n "zsh"
#         tmux attach -t "$session:zsh"
    fi
    tmux $OP -t work
}

function unwork() {
    if $(tmux ls | grep -q work); then
        tmux kill-session -t work
    fi
}

function tmux_lcrown() {
    [[ -n $TMUX ]] && OP="switch" || OP="attach"
    if ! $(tmux ls | grep -q lcrown); then
        tmux new-session -d -s lcrown
    fi
    tmux $OP -t lcrown
}

# projects
function project_switch() {
    PROJ_FILE="$HOME/.proj-list"
    touch $PROJ_FILE
    if [ $# -eq 0 ]; then
        cat $PROJ_FILE | xargs -I{} basename {}
        return
    fi

    case "$1" in
        "a"|"add")
            echo "$(pwd)" >> $PROJ_FILE
            ;;
        "e"|"edit")
            $EDITOR $PROJ_FILE
            ;;
        "r"|"remove"|"rm")
            if [ -z $2 ]; then
                sed -i "" "/$(basename $(pwd))$/d" $PROJ_FILE
            else
                sed -i "" "/$2$/d" $PROJ_FILE
            fi
            ;;
        *)
            if [[ "$(grep "$1" $PROJ_FILE)" = "" ]]; then
                echo "no project: $1"
                return
            fi
            session="$1"
            ppath="$(grep "$session" $PROJ_FILE)"
            [[ -n $TMUX ]] && OP="switch" || OP="attach"
            if ! $(tmux ls | grep -q "$session"); then
                tmux new-session -s "$session" -d
                tmux send-keys -t "$session:1" "cd $ppath" C-m
                tmux send-keys -t "$session:1" "export PROJ=$ppath" C-m
                tmux send-keys -t "$session:1" "clear" C-m
            fi
            tmux $OP -t "$session"
            ;;
    esac
}
alias pj="project_switch"
