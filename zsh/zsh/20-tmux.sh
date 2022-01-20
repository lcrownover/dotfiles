alias t='tmux'

function set_tmux_window_name() {
    [[ -n "$TMUX" ]] && tmux rename-window "$1"
}

function work() {
    [[ -n $TMUX ]] && OP="switch" || OP="attach"
    $(tmux ls | grep -q work) || tmux new-session -d -s work
    tmux $OP -t work
}

function unwork() {
    $(tmux ls | grep -q work) && tmux kill-session -t work
}

function tmux_lcrown() {
    [[ -n $TMUX ]] && OP="switch" || OP="attach"
    if ! $(tmux ls | grep -q lcrown); then
        tmux new-session -d -s lcrown
    fi
    tmux $OP -t lcrown
}

# split after 80 chars
function code_split() {
    tmux split-window -h -l $(echo "$(tput cols) 80 - p" | dc)
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
# alias pj="project_switch"

function vv() {
    case "$1" in
        "")
        name=$(basename $(pwd))
        arg="."
        ;;
        ".")
        name=$(basename $(pwd))
        arg="."
        ;;
        *)
        name=$(basename $1)
        arg="$1"
        ;;
    esac
    tmux new-session -s $name -d
    tmux new-window -t $name -d
    tmux send-keys -t $name:1 "vim $arg" Enter
    if [ $TMUX ]; then
        tmux switch-client -t $name
    else
        tmux attach -t $name
    fi
}
