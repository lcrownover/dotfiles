alias jcode='jupyter_code'

jupyter_code() {
    if [ ! -d .venv ]; then
        echo "only run this command from a directory created by 'jupyter_init'" >&2
        return 1
    fi
    code --profile Jupyter .
}

jupyter_init() {
    local deps=(jupyter jupyterlab pandas datascience requests)
    local project_dir
    local python_version
    local -a uv_args=()

    if [ "$#" -lt 1 ] || [ -z "$1" ]; then
        echo "usage: jupyter_init <project-name> [--python <version>]"
        echo "  creates a new directory with .venv, .vscode settings, and a starter notebook"
        return 1
    fi

    project_dir="$1"
    shift

    while [ "$#" -gt 0 ]; do
        case "$1" in
        --python)
            if [ -z "$2" ]; then
                echo "error: --python requires a version argument" >&2
                return 1
            fi
            python_version="$2"
            uv_args+=(--python "$2")
            shift 2
            ;;
        *)
            echo "error: unknown argument: $1" >&2
            return 1
            ;;
        esac
    done

    if [ -e "$project_dir" ]; then
        echo "error: $project_dir already exists" >&2
        return 1
    fi

    mkdir -p "$project_dir/.vscode" || return 1

    uv venv "$project_dir/.venv" "${uv_args[@]}" || return 1
    VIRTUAL_ENV="$project_dir/.venv" uv pip install "${deps[@]}" || return 1

    cat >"$project_dir/.vscode/settings.json" <<'EOF'
{
    "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python",
}
EOF

    # minimal valid notebook with the kernel pre-selected
    cat >"$project_dir/notebook.ipynb" <<EOF
{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "bac375c7",
   "metadata": {},
   "outputs": [],
   "source": [
    "import pandas as pd"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "428c4857",
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": ".venv ($python_version)",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.14.3"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
EOF

    cd "$project_dir" || return 1
}
