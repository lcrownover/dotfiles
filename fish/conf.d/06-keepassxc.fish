function get_from_keepass
    if test (count $argv) -eq 0
        echo "usage: get_from_keepass ENTRY [attribute]"
        return
    end
    set keepassdbpath "$GDRIVEDIR/lcrown.kdbx"
    set entry $argv[1]
    set attribute (test (count $argv) -ge 2; and echo $argv[2]; or echo password)
    printf "%s" (echo "$KEEPASSDBPW" | "$HOMEBREW_BINDIR"/keepassxc-cli show "$keepassdbpath" "$entry" --attributes "$attribute" -q)
end

function get_from_racs_keepass
    if test (count $argv) -eq 0
        echo "usage: get_from_racs_keepass ENTRY [attribute]"
        return
    end
    set racskeepassdbpw (get_from_keepass 'RACS Keepass')
    set racskeepassdbpath "$HOME/OneDrive - University Of Oregon/O365_RACS_Staff/General/Keepass/racs-keepass.kdbx"
    set entry $argv[1]
    set attribute (test (count $argv) -ge 2; and echo $argv[2]; or echo password)
    printf "%s" (echo "$racskeepassdbpw" | "$HOMEBREW_BINDIR"/keepassxc-cli show "$racskeepassdbpath" "$entry" --attributes "$attribute" -q)
end

function get_from_systems_keepass
    if test (count $argv) -eq 0
        echo "usage: get_from_systems_keepass ENTRY [attribute]"
        return
    end
    set syskeepassdbpw (get_from_keepass 'Keepass - Systems')
    set syskeepassdbpath "$HOME/Documents/systems.kdbx"
    set entry $argv[1]
    set attribute (test (count $argv) -ge 2; and echo $argv[2]; or echo password)
    printf "%s" (echo "$syskeepassdbpw" | "$HOMEBREW_BINDIR"/keepassxc-cli show "$syskeepassdbpath" "$entry" --attributes "$attribute" -q)
end

function keepass_switch
    switch "$argv[1]"
        case 'lc*'
            get_from_keepass 'uoregon'
        case lrc
            get_from_keepass 'talapas'
        case 'lk*'
            get_from_keepass 'keepass'
        case 'keep*'
            get_from_keepass 'Keepass - Systems'
        case dci
            get_from_systems_keepass 'DCI root/admin password'
        case ssh
            get_from_keepass 'uoregon' 'passphrase'
        case mac
            get_from_keepass 'mac'
        case aws
            get_from_keepass 'AWS - aws-lcrown'
        case 'ans*'
            get_from_keepass 'ansible racs'
        case 'racs*'
            get_from_keepass 'RACS Keepass'
        case root
            get_from_racs_keepass 'Talapas - root user'
        case lp
            get_from_keepass 'lastpass'
        case 'test*'
            get_from_keepass 'test account'
        case '*'
            echo "Error: key '$argv[1]' not found"
            return 1
    end
end
