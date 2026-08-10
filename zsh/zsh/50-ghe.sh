#!/bin/bash
#
ghe() {
    my_commands=(
        "gh repo create"
        "gh repo clone"
        "gh run watch"
        "gh run view --log"
    )
    selected=$(printf '%s\n' "${my_commands[@]}" | fzf --height=40% --reverse)
    eval "$selected"
}
