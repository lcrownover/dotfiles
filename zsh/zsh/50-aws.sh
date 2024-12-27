append_path "/usr/local/aws-cli"

#
# Configuring SSO for CLI
#
# Run `aws configure sso --profile AWSACCOUNT` and use the SSO session name "uoregon".
# If we had another organization, you could use another session name.
# To configure a profile (AWS Account), use `aws configure sso --profile racs-prod`,
# give it the session name of `uoregon`, and it will be configured.
# When you need to refresh access keys, just run `aws sso login --profile racs-prod`.
#
# You can also use the `aws-switch-profile` function defined below so you don't
# have to pass `--profile`.
#

export AWS_PROFILE="default"
export AWS_REGION="us-west-2"

function aws-list-profiles() {
    awk '/profile/ {print $2}' ~/.aws/config | tr -d ']'
}

function aws-login() {
    if [ -z "$1" ]; then
        echo "usage: give a valid aws cli profile name for \$1"
        return
    fi
    export AWS_PROFILE="$1"
    aws sso login
    eval "$(aws configure export-credentials --profile $AWS_PROFILE --format env)"
}

function awsdev() {
    ssh ec2-user@ec2-35-87-208-146.us-west-2.compute.amazonaws.com
}

function aws-ami-catalog() {
    edge 'https://us-west-2.console.aws.amazon.com/ec2/home?region=us-west-2#AMICatalog:'
}
