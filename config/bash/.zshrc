# .zshrc 

# Source shared aliases and functions
source "$HOME/.profile"

# tmux sessionizer
bindkey -s ^f "tmux-sessionizer\n"

# reverse search
bindkey '^r' history-incremental-search-backward

bindkey '^[[1;5C' forward-word # Ctrl+right arrow
bindkey '^[[1;5D' backward-word # Ctrl+left arrow

# starship
eval "$(starship init zsh)"
