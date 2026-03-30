# remove welcome message
set fish_greeting

# OS detection
switch (uname -a)
    case 'Darwin*'
        set -gx DOT_OS mac
    case '*WSL*'
        set -gx DOT_OS wsl
    case '*'
        set -gx DOT_OS linux
end

# Homebrew
switch (uname -p)
    case i386
        set -gx HOMEBREW_BINDIR /usr/local/bin
    case '*'
        set -gx HOMEBREW_BINDIR /opt/homebrew/bin
end

if test "$DOT_OS" = mac
    eval ($HOMEBREW_BINDIR/brew shellenv)
end

function fish_prompt
    set -g __fish_git_prompt_showcolorhints true
    set -g __fish_git_prompt_showdirtystate true
    string join '' -- (set_color blue) (prompt_pwd --full-length-dirs 2) (set_color normal) (fish_git_prompt) (set_color purple) ' > ' (set_color normal)
end

fish_add_path /opt/homebrew/bin/

set -gx EDITOR nvim
set -gx VISUAL zed
set -gx COLORTERM truecolor

ulimit -n 4096

