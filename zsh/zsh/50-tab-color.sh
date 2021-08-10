tab-color() {
    echo -ne "\033]6;1;bg;red;brightness;$1\a"
    echo -ne "\033]6;1;bg;green;brightness;$2\a"
    echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}
tab-reset() {
    echo -ne "\033]6;1;bg;*;default\a"
}
color-ssh() {
    if [[ -n "$ITERM_SESSION_ID" ]]; then
        trap "tab-reset" INT EXIT
        if [[ "$*" =~ "is-puppetca1" ]]; then
            tab-color 0 255 255
        elif [[ "$*" =~ "is-puppet?" ]]; then
            tab-color 0 0 255
        elif [[ "$*" =~ "tape" ]]; then
            tab-color 255 128 0
        elif [[ "$*" =~ "is-nagios1" ]]; then
            tab-color 255 0 255
        elif [[ "$*" =~ "is-foreman-prod1" ]]; then
            tab-color 255 255 0
        elif [[ "$*" =~ "is-rhn*" ]]; then
            tab-color 255 0 0
        elif [[ "$*" =~ "satellite*" ]]; then
            tab-color 255 0 0
        elif [[ "$*" =~ "is-lc-forge*" ]]; then
            tab-color 255 162 0
        elif [[ "$*" =~ "eitri" ]]; then
            tab-color 255 162 0
        else
            tab-reset
        fi
    fi
    ssh $*
}
