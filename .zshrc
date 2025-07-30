# .zshrc 

# preferred editors
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
  export VISUAL='nvim'
fi

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

# completion
autoload -Uz compinit
compinit

# vim bindings
bindkey -v

# bindings
bindkey -s ^F "tmux-sessionizer\n"
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

# aliases
alias up="brew upgrade"
alias l="ls -al --color=auto"
alias ls="ls --color=auto"
alias nv="nvim ."

# scripts
export PATH="$HOME/.dotfiles/bin:$PATH"


# fzf
source <(fzf --zsh)
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=fg:#c0caf5,bg:#1a1b26,hl:#ff9e64 \
--color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"

# go
export PATH="$HOME/go/bin:$PATH"

# zig
export PATH="/usr/local/zig:$PATH"

# rust
export PATH="$HOME/.cargo/bin:$PATH"
source "$HOME/.cargo/env"

# starship
eval "$(starship init zsh)"
