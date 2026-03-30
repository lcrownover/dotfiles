fish_add_path $HOME/.local/bin

function spushd
    pushd $argv[1] >/dev/null
end

function spopd
    if test (count $dirstack) -gt 0
        popd >/dev/null
    end
end

function dir_jump
    set search_dirs \
        "$HOME/racs" \
        "$HOME/code" \
        "$HOME/aws" \
        "$HOME/azure" \
        "$HOME/puppet" \
        "$HOME/work"
    set max_depth 3

    switch "$argv[1]"
        case 'racs*'
            cd "$HOME/racs/racs-ansible"
            return
        case 'doc*'
            cd "$HOME/racs/racs-internal-docs"
            return
        case 'dot*'
            cd "$HOME/.dotfiles"
            return
        case 'sch*'
            cd "$HOME/Google Drive/My Drive/school"
            return
        case 'aws*'
            set search_dirs "$HOME/work/cloud/aws/uo-cloud-infra/"
            set max_depth 1
    end

    cd (fd --max-depth $max_depth --type directory . $search_dirs | fzf --query="$argv[1]")
end
alias j dir_jump

function vim_notes
    spushd .
    cd "$NOTESDIR"
    set_tmux_window_name notes
    if test -z "$argv[1]"
        nvim .
    else
        nvim $argv[1]
    end
    reset_tmux_window_name
    spopd
end

# copy file contents to clipboard
function cl
    pbcopy < $argv[1]
end

# search and cd with fzf
function vs
    cd "$HOME/code"
    cd (fd --max-depth 2 --type directory | fzf)
    nvim .
end

# gnu sed for MacOS
if test -f $HOMEBREW_BINDIR/gsed
    alias sed gsed
end

function firefox
    if test "$DOT_OS" = mac
        /Applications/Firefox.app/Contents/MacOS/firefox file://(pwd)/$argv[1]
    end
end

function edge
    if test "$DOT_OS" = mac
        open -a "Microsoft Edge" $argv[1]
    end
end

# clangd
insert_path /usr/local/opt/llvm/bin

function known_hosts_remove
    if not string match -qr '^[0-9]+$' $argv[1]
        echo "bad input $argv[1]"
    else
        gsed -i -e "$argv[1]d" "$HOME/.ssh/known_hosts"
    end
end

function ssh_load_keys
    # ssh-agent -s outputs bash syntax; parse it manually for fish
    for line in (ssh-agent -s | head -2)
        set -l parts (string replace 'export ' '' $line | string split -m 1 '=')
        set -gx $parts[1] (string replace ';' '' $parts[2])
    end
    ssh-add ~/.ssh/uoregon/id_rsa
    ssh-add ~/.ssh/github/id_rsa
end

alias bat 'bat --theme=ansi'

# Ctrl-Z: fg if buffer is empty, otherwise suspend
function __fancy_ctrl_z
    if test -z (commandline)
        fg 2>/dev/null
    else
        commandline -f suspend
    end
end
bind \cz __fancy_ctrl_z
