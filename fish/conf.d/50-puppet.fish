set -gx PUPPET_BASE_DIR "$HOME/puppet/is"
alias pdk 'docker run --rm -it -v (pwd):/workspace -w /workspace localhost:3000/pdk/pdk:latest'

function puppet_navigate_to_basedir
    if test -z "$argv[1]"
        cd "$PUPPET_BASE_DIR"
    else
        cd "$PUPPET_BASE_DIR/puppet_$argv[1]"
    end
end

function puppet_list_puppet_directories
    for f in (find $PUPPET_BASE_DIR -mindepth 1 -maxdepth 1 -type d | grep -v vscode | grep -v _mass_scripts)
        basename $f
    end
end

function puppet_git_status_all
    set tmp ~/temp/.gsapout
    spushd .
    puppet_navigate_to_basedir
    for pdir in (puppet_list_puppet_directories)
        cd $pdir
        if test (git status --porcelain | wc -l) -gt 0
            if test "$argv[1]" = long
                printf "[%s] %s\n" (git rev-parse --abbrev-ref HEAD) $pdir | tee -a $tmp
                printf "%s\n\n" (git diff) >> $tmp
            else
                printf "[%s] %s\n" (git rev-parse --abbrev-ref HEAD) $pdir
                git status --porcelain
            end
        end
        cd ..
    end
    spopd
    if test "$argv[1]" = long
        vim $tmp
    end
    echo > $tmp
end

function puppet_pull_all
    set cwd (pwd)
    puppet_navigate_to_basedir
    for pdir in (puppet_list_puppet_directories)
        cd $pdir
        if test "$argv[1]" = master
            git checkout master --quiet
        end
        printf "[%s] %s\n" (git branch --show-current) $pdir
        git pull origin (git rev-parse --abbrev-ref HEAD) --quiet
        cd ..
    end
    cd $cwd
end

alias cdp puppet_navigate_to_basedir
alias pgpa puppet_pull_all
alias pgsa puppet_git_status_all

function pat
    bolt command run "puppet agent --test" --targets $argv[1] --transport pcp
end

function code_puppet
    spushd .
    cdp
    code puppet-control-repo/inventory.yaml
    spopd
end
alias cip code_puppet

set pdk_version_tag "3.5.1.1.30.g7d6a7d3"

function ppv
    if test -z "$argv[1]"
        echo "Usage: ppv <version>"
        return 1
    end
    set pdkversion $argv[1]
    set dockerimage "puppet/pdk:$pdkversion"
    docker run --rm --platform linux/amd64 -v $PWD:/workspace $dockerimage validate --parallel
end

function ees
    if test -z "$argv[1]"
        echo "usage: ees <string to encrypt>"
        return
    end
    eyaml encrypt --pkcs7-public-key="$PUPPET_BASE_DIR/puppet_systems/pe_pub_key.pem" --output=block --string="$argv[1]"
end

function eef
    if test -z "$argv[1]"
        echo "usage: eef <path to file to encrypt>"
        return
    end
    eyaml encrypt --pkcs7-public-key="$PUPPET_BASE_DIR/puppet_systems/pe_pub_key.pem" --output=block --file="$argv[1]"
end
