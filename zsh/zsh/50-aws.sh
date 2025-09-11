#!/usr/bin/env bash

append_path "/usr/local/aws-cli"

AWS_PROFILE_MANAGER="$HOME/.config/zsh/scripts/aws-profiles.py"

#
# Configuring SSO for CLI (old)
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

#
# Make sure you have a "uoregon" session configured in your $HOME/.aws/config
# [sso-session uoregon]
# sso_start_url = https://d-9267f25f0e.awsapps.com/start
# sso_region = us-west-2
# sso_registration_scopes = sso:account:access
#

export AWS_REGION="us-west-2"

function aws-list-profiles() {
    awk '/profile/ {print $2}' ~/.aws/config | tr -d ']'
}

function aws-profile-add() {
    if [ -z "$1" ]; then
        echo "usage: give a profile name for \$1"
        return
    fi
    python "$AWS_PROFILE_MANAGER" add "$1"
}

function aws-profile-remove() {
    if [ -z "$1" ]; then
        echo "usage: give a profile name for \$1"
        return
    fi
    python "$AWS_PROFILE_MANAGER" remove "$1"
}

function aws-login-profile() {
    if [ -z "$1" ]; then
        echo "usage: give a valid aws cli profile name for \$1"
        return
    fi
    export AWS_PROFILE="$1"
    aws --profile "$AWS_PROFILE" sts get-caller-identity >/dev/null 2>&1 ||
        aws sso login
    eval "$(aws configure export-credentials --profile "$AWS_PROFILE" --format env)"
}

function aws-login() {
    if [ -z "$1" ]; then
        profile_name=$(python "$AWS_PROFILE_MANAGER" list | fzf)
    else
        profile_name="$1"
    fi
    aws-login-profile "$profile_name"
}

function awsdev() {
    ssh ec2-user@ec2-35-87-208-146.us-west-2.compute.amazonaws.com
}

function aws-ami-catalog() {
    edge 'https://us-west-2.console.aws.amazon.com/ec2/home?region=us-west-2#AMICatalog:'
}

function ssm() {
    if [ -z "$1" ]; then
        echo "usage: give a valid instance id for \$1"
        return
    fi
    aws ssm start-session --target "$1"
}
