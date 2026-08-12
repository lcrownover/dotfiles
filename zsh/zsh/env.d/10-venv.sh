VENVS_PATH="$HOME/.venvs"
venv_usage() {
    cat <<EOF
Usage: venv [OPTIONS] [<input>]

Silly little tool to create and select central UV venvs.

Options:
  -h, --help          Show this help message and exit
  -l, --list          List available venvs
  -c, --create        Create a new venv
  -d, --delete        Delete a venv

Examples:
  Select venv from picker
      venv
  Activate a venv by name
      venv <name>
  Show all available venvs
      venv --list
  Get information on a specific venv 
      venv --info <name>
  Create a new venv
      venv --create my_new_venv
  Create a new venv with specific python version
      venv --create my_new_venv --python 3.14
  Delete a venv by name
      venv --delete <name> [-y]
EOF
}
venv() {
    case "$1" in
    "-h" | "--help")
        venv_usage
        return
        ;;
    "-l" | "--list")
        fd --type d --max-depth 1 . "$VENVS_PATH" | xargs -n1 basename
        return
        ;;
    "-i" | "--info")
        shift
        if [ -d "$VENVS_PATH/$1" ]; then
            PYTHON_VERSION="$(grep "version_info" "$VENVS_PATH/$1/pyvenv.cfg" | awk '{print $3}')"
            echo "path:             $VENVS_PATH/$1"
            echo "python version:   $PYTHON_VERSION"
            return
        else
            echo "venv not found: $1"
            return
        fi
        ;;
    "-c" | "--create")
        shift
        NAME="$1"
        shift
        uv venv "$VENVS_PATH/$NAME" "$@"
        return
        ;;
    "-d" | "--delete")
        shift
        venv_delete_venv() {
            test -d "$VENVS_PATH/$1" && rm -rf "$VENVS_PATH/${1:?}"
            return
        }
        NAME="$1"
        if [ -z "$NAME" ]; then
            echo "venv name required"
            return
        fi
        shift
        if [ "$1" = "-y" ]; then
            AUTO=1
        else
            AUTO=0
        fi
        if [ "$AUTO" -eq "1" ]; then
            venv_delete_venv "$NAME"
            return
        fi

        printf "deleting venv %s, continue? (y/n): " "$NAME"
        read -r ans
        if [[ "$ans" == [yY] ]]; then
            venv_delete_venv "$NAME"
        else
            echo "cancelled"
        fi
        ;;
    "")
        ENV="$(fd --type d --max-depth 1 . "$VENVS_PATH" | xargs -n1 basename | fzf)"
        test ! -z $ENV || return
        source "$VENVS_PATH/$ENV/bin/activate"
        return
        ;;
    *)
        if [ -d "$VENVS_PATH/$1" ]; then
            source "$VENVS_PATH/$1/bin/activate"
            return
        else
            echo "venv not found: $1"
            return
        fi
        ;;
    esac
}
