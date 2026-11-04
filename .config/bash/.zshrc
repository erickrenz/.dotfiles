# .zshrc 

# Source shared aliases and functions
source "$HOME/.profile"

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

# Completion
autoload -Uz compinit
compinit

# vim bindings; set first, since it resets the keymap the bindings below go into
bindkey -v

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# tmux sessionizer
bindkey -s ^f "tmux-sessionizer\n"

bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
bindkey '^[[1;5C' forward-word # Ctrl+right arrow
bindkey '^[[1;5D' backward-word # Ctrl+left arrow

# starship
eval "$(starship init zsh)"
