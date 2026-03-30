fish_add_path $HOME/.npm/bin
set -gx NODE_PATH $NODE_PATH $HOME/.npm/lib/node_modules

# NVM is bash-specific and won't source directly in fish.
# Options:
#   - nvm.fish:  fisher install jorgebucaran/nvm.fish
#   - fnm:       fnm env --use-on-cd | source
set -gx NVM_DIR "$HOME/.nvm"
