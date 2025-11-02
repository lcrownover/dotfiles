#!/bin/bash

if [[ -d $HOME/.pyenv ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init - --no-rehash zsh)"
    # eval "$(pyenv virtualenv-init -)"
fi
