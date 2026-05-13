function get_from_bitwarden() {
    if [ $# -eq 0 ]; then
        echo "usage: $0 ENTRY [attribute]"
        return
    fi
    BW_SESSION_KEY=$(bw unlock --passwordenv BW_MASTER_PASSWORD --raw)
    entry="$1"
    if [ "$2" = "" ]; then attribute="password"; else attribute="$2"; fi
    bw get "$attribute" "$entry" --session "$BW_SESSION_KEY"
    bw lock >/dev/null &
}

function bitwarden_switch() {
    case "$1" in
    lc*)
        get_from_bitwarden 'uoregon'
        ;;
    lrc)
        get_from_bitwarden 'talapas'
        ;;
    lk*)
        get_from_bitwarden 'keepass'
        ;;
    keep*)
        get_from_bitwarden 'Keepass - Systems'
        ;;
    dci)
        get_from_systems_bitwarden 'DCI root/admin password'
        ;;
    ssh)
        get_from_bitwarden 'uoregon' 'passphrase'
        ;;
    mac)
        get_from_bitwarden 'mac'
        ;;
    aws)
        get_from_bitwarden 'AWS - aws-lcrown'
        ;;
    ans*)
        get_from_bitwarden 'ansible racs'
        ;;
    racs*)
        get_from_bitwarden 'RACS Keepass'
        ;;
    root)
        get_from_racs_bitwarden 'Talapas - root user'
        ;;
    lp)
        get_from_bitwarden 'lastpass'
        ;;
    test*)
        get_from_bitwarden 'test account'
        ;;
    *)
        echo "Error: key '$1' not found"
        exit 1
        ;;
    esac
}
