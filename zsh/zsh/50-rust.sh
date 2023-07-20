if ! [ "$DOT_OS" = "mac" ]; then
    return
fi

insert_path "$HOME/.cargo/bin"
. "$HOME/.cargo/env"
