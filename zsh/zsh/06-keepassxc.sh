function get_from_keepass() {
    if [ $# -eq 0 ]; then
        echo "usage: $0 entry [attribute]"
        return
    fi
    KEEPASSDBPATH="$GDRIVEDIR/lcrown.kdbx"
    entry="$1"
    if [ "$2" = "" ]; then attribute="password"; else attribute="$2"; fi
    printf "%s" "$(echo $KEEPASSDBPW | $HOMEBREW_BINDIR/keepassxc-cli show $KEEPASSDBPATH "$entry" --attributes "$attribute" -q)"
}

get_from_systems_keepass() {
    if [ $# -eq 0 ]; then
        echo "usage: $0 entry [attribute]"
        return
    fi
    SYSKEEPASSDBPW="$(get_from_keepass 'Keepass - Systems')"
    SYSKEEPASSDBPATH="$HOME/Documents/systems.kdbx"
    entry="$1"
    if [ "$2" = "" ]; then attribute="password"; else attribute="$2"; fi
    printf "%s" "$(echo $SYSKEEPASSDBPW | $HOMEBREW_BINDIR/keepassxc-cli show $SYSKEEPASSDBPATH "$entry" --attributes "$attribute" -q)"
}
