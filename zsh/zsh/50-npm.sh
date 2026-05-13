append_path "$HOME/.npm/bin"
export NODE_PATH=$NODE_PATH:$HOME/.npm/lib/node_modules

# lazy load
export NVM_DIR="$HOME/.nvm"
nvm() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion" # This loads nvm bash_completion for all future npm calls
}
