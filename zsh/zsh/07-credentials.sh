# various credentials gotten from keepass

if ! [ "$DOT_OS" = "mac" ]; then
	return
fi

function load_token() {
	case "$1" in
	"github")
		GITHUB_TOKEN="$(get_from_keepass 'Github' 'token -- lcrown')"
		export GITHUB_TOKEN=$GITHUB_TOKEN
		;;
	"galaxy")
		ANSIBLE_GALAXY_API_KEY="$(get_from_keepass 'Ansible Galaxy' 'api_key')"
		export ANSIBLE_GALAXY_API_KEY=$ANSIBLE_GALAXY_API_KEY
		;;
	esac
}
