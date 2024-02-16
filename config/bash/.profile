# .profile

# User specific aliases and functions
export LANG=en_US.UTF-8
export LC_ALL="C.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

alias v="nvim"
alias vim="nvim"
alias nv="nvim ."

alias l="ls -al --color=auto"
alias ls="ls --color=auto"
alias neo="neofetch"
alias docker="podman"

if [[ -e /bin/dnf || -e /usr/bin/dnf ]]; then
  alias up="sudo dnf upgrade -y"
elif [[ -e /bin/pacman || -e /usr/bin/pacman ]]; then
  alias up="sudo pacman -Syu"
elif [[ -e /usr/local/bin/brew ]]; then
  alias up="brew upgrade -q"
  alias docker="docker"
fi

# fzf colors
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=fg:#c0caf5,bg:#1a1b26,hl:#ff9e64 \
--color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"

# scripts
export PATH="$HOME/.dotfiles/scripts:$PATH"

# cargo
export PATH="$HOME/.cargo/bin:$PATH"
source "$HOME/.cargo/env"
