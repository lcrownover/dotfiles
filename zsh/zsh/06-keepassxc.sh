function get_from_keepass() {
    if [ $# -eq 0 ]; then
        echo "usage: $0 ENTRY [attribute]"
        return
    fi
    KEEPASSDBPATH="$GDRIVEDIR/lcrown.kdbx"
    entry="$1"
    if [ "$2" = "" ]; then attribute="password"; else attribute="$2"; fi
    printf "%s" "$(echo $KEEPASSDBPW | $HOMEBREW_BINDIR/keepassxc-cli show $KEEPASSDBPATH "$entry" --attributes "$attribute" -q)"
}

function get_from_racs_keepass() {
    if [ $# -eq 0 ]; then
        echo "usage: $0 ENTRY [attribute]"
        return
    fi
    RACSKEEPASSDBPW="$(get_from_keepass 'RACS Keepass')"
    RACSKEEPASSDBPATH="$HOME/OneDrive - University Of Oregon/RACS-KeePass/racs-keepass.kdbx"
    entry="$1"
    if [ "$2" = "" ]; then attribute="password"; else attribute="$2"; fi
    printf "%s" "$(echo $RACSKEEPASSDBPW | $HOMEBREW_BINDIR/keepassxc-cli show $RACSKEEPASSDBPATH "$entry" --attributes "$attribute" -q)"
}

function get_from_systems_keepass() {
    if [ $# -eq 0 ]; then
        echo "usage: $0 ENTRY [attribute]"
        return
    fi
    SYSKEEPASSDBPW="$(get_from_keepass 'Keepass - Systems')"
    SYSKEEPASSDBPATH="$HOME/Documents/systems.kdbx"
    entry="$1"
    if [ "$2" = "" ]; then attribute="password"; else attribute="$2"; fi
    printf "%s" "$(echo $SYSKEEPASSDBPW | $HOMEBREW_BINDIR/keepassxc-cli show $SYSKEEPASSDBPATH "$entry" --attributes "$attribute" -q)"
}

function keepass_switch() {
    case "$1" in
        lc*)
            get_from_keepass 'uoregon'
            ;;
        lrc)
            get_from_keepass 'talapas'
            ;;
        lk*)
            get_from_keepass 'keepass'
            ;;
        keep*)
            get_from_keepass 'Keepass - Systems'
            ;;
        dci)
            get_from_systems_keepass 'DCI root/admin password'
            ;;
        ssh)
            get_from_keepass 'uoregon' 'passphrase'
            ;;
        mac)
            get_from_keepass 'mac'
            ;;
        aws)
            get_from_keepass 'AWS - aws-lcrown'
            ;;
        ans*)
            get_from_keepass 'ansible racs'
            ;;
        racs*)
            get_from_keepass 'RACS Keepass'
            ;;
        root)
            get_from_racs_keepass 'Talapas - root user'
            ;;
        lp)
            get_from_keepass 'lastpass'
            ;;
        test*)
            get_from_keepass 'test account'
            ;;
        *)
            echo "Error: key '$1' not found"
            exit 1
            ;;
    esac
}
