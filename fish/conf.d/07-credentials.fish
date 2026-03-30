if test "$DOT_OS" != mac
    return
end

function load_token
    switch "$argv[1]"
        case github
            set -gx GITHUB_TOKEN (get_from_keepass 'Github' 'token -- lcrown')
        case galaxy
            set -gx ANSIBLE_GALAXY_API_KEY (get_from_keepass 'Ansible Galaxy' 'api_key')
        case *
            echo "pass the type of token as \$1"
    end
end
