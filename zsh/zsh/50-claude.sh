alias sclaude='cd $(mktemp -d) && set_tmux_window_name scratch-claude && claude'

cclocal() {
  ANTHROPIC_BASE_URL=http://localhost:1234 \
  ANTHROPIC_AUTH_TOKEN=lmstudio \
  ANTHROPIC_API_KEY="" \
  claude --model qwen3.5-4b "$@"
}
