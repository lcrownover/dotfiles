# openconnect vpn
vpn_usage() {
    printf "usage:\n"
    printf "    vpn start [token]\n"
    printf "        start the vpn client. if token is not passed, will push to duo mobile\n"
    printf "    vpn stop\n"
    printf "        stop the vpn client\n"
    printf "    vpn status\n"
    printf "        check the vpn client status\n"
    printf "    vpn dns [subcommand]\n"
    printf "        'set' or 'unset' to configure DNS manually\n"
}

vpn_set_dns() {
    networksetup -setdnsservers 'Thunderbolt Ethernet Slot 2' 128.223.32.36 128.223.60.23
    networksetup -setdnsservers 'Wi-Fi' 128.223.32.36 128.223.60.23
    networksetup -setsearchdomains 'Thunderbolt Ethernet Slot 2' uoregon.edu
    networksetup -setsearchdomains 'Wi-Fi' uoregon.edu
}

vpn_unset_dns() {
    networksetup -setdnsservers 'Thunderbolt Ethernet Slot 2' Empty
    networksetup -setdnsservers 'Wi-Fi' Empty
    networksetup -setsearchdomains 'Thunderbolt Ethernet Slot 2' Empty
    networksetup -setsearchdomains 'Wi-Fi' Empty
}

vpn_pid() {
    ps ax | grep -v grep | grep 'sudo openconnect --config' | awk '{print $1}'
}

vpn_connect() {
    if [ "$1" = "" ]; then
        TOKEN=push
    else
        TOKEN="$1"
    fi
    VPNCONF="$HOME/.config/openconnect/openconnect.conf"
    (echo $(get_from_keepass 'uoregon'); echo $TOKEN) | sudo openconnect --config=$VPNCONF --passwd-on-stdin
}

sudo_auth() {
    echo $(get_from_keepass 'mac') | sudo -S true
}

vpn() {
    if [ "$#" -eq "0" ]; then
        vpn_usage
        return
    fi

    while (( $# )); do
        case "$1" in
            "stop")
                OP="stop"
                shift
                ;;
            "status")
                OP="status"
                shift
                ;;
            "start")
                OP="start"
                shift
                if [ ! -z "$1" ]; then
                    TOKEN="$1"
                    shift
                fi
                ;;
            "dns")
                OP="dns"
                shift
                SUB="$1"
                shift
                ;;
            *)
                vpn_usage
                return
                ;;
        esac
    done


    if [ "$OP" = "stop" ]; then
        unset OP
        sudo_auth
        PID=$(vpn_pid)
        if [[ $PID ]]; then
            sudo kill $PID
        fi
        unset PID
        (tmux list-sessions | grep -q openconnect) && tmux kill-session -t openconnect
        vpn_unset_dns
        return
    fi

    if [ "$OP" = "status" ]; then
        PID=$(vpn_pid)
        if [[ $PID ]]; then
            printf "VPN is running\n"
        else
            printf "VPN is stopped\n"
        fi
        unset PID
        return
    fi

    if [ "$OP" = "start" ]; then
        tmux list-sessions | grep -q openconnect || tmux new-session -s "openconnect" -n "vpn" -d
        ps ax | grep -v grep | grep -q 'openconnect --config'
        if [ $? -eq 1 ]; then
            tmux send-keys -t "openconnect:vpn" "sudo_auth" Enter
            tmux send-keys -t "openconnect:vpn" "vpn_connect $TOKEN" Enter
        fi
        echo "Connecting to VPN..."
        sleep 5
        vpn_set_dns
        unset TOKEN
        return
    fi

    if [ "$OP" = "dns" ]; then
        case "$SUB" in
            "set")
                vpn_set_dns
                return
                ;;
            "unset")
                vpn_unset_dns
                return
                ;;
            *)
                vpn_usage
                return
                ;;
        esac
    fi
}
