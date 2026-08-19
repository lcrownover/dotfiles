append_path "/usr/local/aws-cli"
export AWS_REGION="us-west-2"

ln -sf "$HOME/.config/zsh/scripts/aws-profile-manager" "$HOME/.local/bin/aws-profile-manager"

aws-login() {
    if [ -z "$1" ]; then
        AWS_PROFILE="$(aws-profile-manager list | fzf)"
    else
        AWS_PROFILE="$1"
    fi
    [ "$AWS_PROFILE" = "" ] && return
    aws --profile "$AWS_PROFILE" sts get-caller-identity >/dev/null 2>&1 || aws sso login --profile "$AWS_PROFILE"
    eval "$(aws configure export-credentials --profile "$AWS_PROFILE" --format env)"
}

aws-ami-catalog() {
    edge 'https://us-west-2.console.aws.amazon.com/ec2/home?region=us-west-2#AMICatalog:'
}

ssm() {
    if [ -z "$1" ]; then
        echo "usage: give a valid instance id for \$1"
        return
    fi
    aws ssm start-session --target "$1"
}
