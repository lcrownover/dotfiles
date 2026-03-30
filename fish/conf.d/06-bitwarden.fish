function get_from_bitwarden
    if test (count $argv) -eq 0
        echo "usage: get_from_bitwarden ENTRY [attribute]"
        return
    end
    set bw_session_key (bw unlock --passwordenv BW_MASTER_PASSWORD --raw)
    set entry $argv[1]
    set attribute (test (count $argv) -ge 2; and echo $argv[2]; or echo password)
    bw get "$attribute" "$entry" --session "$bw_session_key"
    bw lock >/dev/null &
end

function bitwarden_switch
    switch "$argv[1]"
        case 'lc*'
            get_from_bitwarden 'uoregon'
        case lrc
            get_from_bitwarden 'talapas'
        case 'lk*'
            get_from_bitwarden 'keepass'
        case 'keep*'
            get_from_bitwarden 'Keepass - Systems'
        case dci
            get_from_systems_bitwarden 'DCI root/admin password'
        case ssh
            get_from_bitwarden 'uoregon' 'passphrase'
        case mac
            get_from_bitwarden 'mac'
        case aws
            get_from_bitwarden 'AWS - aws-lcrown'
        case 'ans*'
            get_from_bitwarden 'ansible racs'
        case 'racs*'
            get_from_bitwarden 'RACS Keepass'
        case root
            get_from_racs_bitwarden 'Talapas - root user'
        case lp
            get_from_bitwarden 'lastpass'
        case 'test*'
            get_from_bitwarden 'test account'
        case '*'
            echo "Error: key '$argv[1]' not found"
            return 1
    end
end
