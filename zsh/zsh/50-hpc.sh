function talapas_connect() {
	function talapas_connect_usage() {
		echo "Usage: talapas_connect <cluster_num> [<node>]"
	}
	if [[ -z "$1" ]]; then
		talapas_connect_usage
		return 1
	fi
	case "$1" in
	1)
		domain="uoregon.edu"
		username="lrc"
		;;
	2)
		domain="talapas.uoregon.edu"
		username="adm-lcrown"
		;;
	*)
		echo "Invalid cluster number: $1, must be 1 or 2"
		talapas_connect_usage
		return 1
		;;
	esac
	shift

	hostname="$1"
	if [ -z "$1" ]; then
		hostname="login"
	fi
	shift

	ssh "$username"@"$hostname"."$domain" "$@"
}
alias t1h="talapas_connect 1 talapas-hn1"

alias t2h="talapas_connect 2 head1"
alias t2t="talapas_connect 2 toolbox"

alias wintool="ssh adm-lcrown@is-racs-wintool"
