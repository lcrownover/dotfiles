alias t='tmux'

function set_tmux_window_name() {
    [[ -n "$TMUX" ]] && tmux rename-window "$1"
}

function main() {
    # [[ -n $TMUX ]] && OP="switch" || OP="attach"
    # $(tmux ls | grep -q main) || tmux new-session -d -s main
    # tmux $OP -t main
    tmux new-session -A -s main
}

function unmain() {
    $(tmux ls | grep -q main) && tmux kill-session -t main
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

ts() {
    case "$1" in
        "")
            tmux list-sessions
            ;;
        *)
            [[ -n $TMUX ]] && OP="switch" || OP="attach"
            $(tmux ls | grep -q "$1") || tmux new-session -d -s "$1"
            tmux $OP -t "$1"
            ;;
    esac
}

tn() {
    case "$1" in
        "")
            tmux rename-window "zsh"
            ;;
        *)
            tmux rename-window "$1"
            ;;
    esac
}

