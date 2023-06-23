# various credentials gotten from keepass

if ! [ "$OS" = "mac" ]; then
	return
fi

function load_token() {
	case "$1" in
	"github")
		export GITHUB_TOKEN="$(get_from_keepass 'Github' 'token -- lcrown')"
		;;
	"galaxy")
		export ANSIBLE_GALAXY_API_KEY="$(get_from_keepass 'Ansible Galaxy' 'api_key')"
		;;
	esac
}
