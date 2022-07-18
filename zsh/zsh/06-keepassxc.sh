function get_from_keepass() {
    if [ $# -eq 0 ]; then
        echo "usage: $0 entry [attribute]"
        return
    fi
    KEEPASSDBPATH="$GDRIVEDIR/lcrown.kdbx"
    entry="$1"
    if [ "$2" = "" ]; then attribute="password"; else attribute="$2"; fi
    printf "%s" "$(echo $KEEPASSDBPW | /opt/homebrew/bin/keepassxc-cli show $KEEPASSDBPATH "$entry" --attributes "$attribute" -q)"
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
    printf "%s" "$(echo $SYSKEEPASSDBPW | /opt/homebrew/bin/keepassxc-cli show $SYSKEEPASSDBPATH "$entry" --attributes "$attribute" -q)"
}
