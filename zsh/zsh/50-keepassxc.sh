function get_from_keepass() {
    if [ $# -ne 1 ]; then
        echo "usage: $0 entryname"
    else
        entry="$1"
        echo "$(echo $KEEPASSDBPW | keepassxc-cli show $HOME/$GDRIVEDIR/lcrown.kdbx "$entry" --attributes password -q)"
    fi
}
