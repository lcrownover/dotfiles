function get_from_keepass() {
    if [ $# -eq 0 ]; then
        echo "usage: $0 entry [attribute]"
        return
    fi
    entry="$1"
    if [ "$2" = "" ]; then attribute="password"; else attribute="$2"; fi
    echo "$(echo $KEEPASSDBPW | keepassxc-cli show $HOME/$GDRIVEDIR/lcrown.kdbx "$entry" --attributes "$attribute" -q)"
}
