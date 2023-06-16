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
	else
		ssh adm-lcrown@$1.talapas.uoregon.edu
	fi
}
