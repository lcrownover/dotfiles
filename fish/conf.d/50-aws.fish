fish_add_path /usr/local/aws-cli

# Path to AWS profile manager script
set -g AWS_PROFILE_MANAGER "$HOME/.config/fish/scripts/aws-profiles.py"

set -gx AWS_REGION us-west-2

function aws-list-profiles
    awk '/profile/ {print $2}' ~/.aws/config | tr -d ']'
end

function aws-profile-add
    if test -z "$argv[1]"
        echo "usage: give a profile name for \$1"
        return
    end
    python3 "$AWS_PROFILE_MANAGER" add $argv[1]
end

function aws-profile-remove
    if test -z "$argv[1]"
        echo "usage: give a profile name for \$1"
        return
    end
    python3 "$AWS_PROFILE_MANAGER" remove $argv[1]
end

function aws-login-profile
    if test -z "$argv[1]"
        echo "usage: give a valid aws cli profile name for \$1"
        return
    end
    set -gx AWS_PROFILE $argv[1]
    aws --profile "$AWS_PROFILE" sts get-caller-identity >/dev/null 2>&1; or aws sso login
    for line in (aws configure export-credentials --profile "$AWS_PROFILE" --format env)
        set -l parts (string replace 'export ' '' $line | string split -m 1 '=')
        set -gx $parts[1] $parts[2]
    end
end

function aws-login
    if test -z "$argv[1]"
        set profile_name (python3 "$AWS_PROFILE_MANAGER" list | fzf)
    else
        set profile_name $argv[1]
    end
    aws-login-profile "$profile_name"
end

function awsdev
    ssh ec2-user@ec2-35-87-208-146.us-west-2.compute.amazonaws.com
end

function aws-ami-catalog
    edge 'https://us-west-2.console.aws.amazon.com/ec2/home?region=us-west-2#AMICatalog:'
end

function ssm
    if test -z "$argv[1]"
        echo "usage: give a valid instance id for \$1"
        return
    end
    aws ssm start-session --target $argv[1]
end

function delete-tf-lock
    if test -z "$argv[1]"
        echo "usage: give the dynamodb table name for \$1"
        return
    end
    aws dynamodb scan --table-name sample-app-630391674139-tfstate-lock --attributes-to-get "LockID" --query "Items[*]" --output json |
        jq -c '.[]' |
        while read -l item
            aws dynamodb delete-item --table-name sample-app-630391674139-tfstate-lock --key "$item"
        end
end
