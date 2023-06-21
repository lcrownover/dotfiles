function t1() {
	if [ -z "$1" ]; then
		ssh lrc@talapas-ln1.uoregon.edu
	else
		ssh lrc@$1.uoregon.edu
	fi
}

function t2() {
	if [ -z "$1" ]; then
		ssh adm-lcrown@login.talapas.uoregon.edu
	fi
	case "$1" in
	"t")
		ssh adm-lcrown@toolbox.talapas.uoregon.edu
		;;
	"h")
		ssh adm-lcrown@head1.talapas.uoregon.edu
		;;
	"l")
		ssh adm-lcrown@login1.talapas.uoregon.edu
		;;
	*)
		ssh adm-lcrown@$1.talapas.uoregon.edu
		;;
	esac
}
