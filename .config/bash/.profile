# .profile

# Move a dir to the front of PATH, dropping any earlier copy, so nested shells
# don't grow PATH and things prepended later (brew shellenv, macOS path_helper)
# can't push it back.
path_prepend() {
  PATH=":$PATH:"
  PATH="${PATH//:"$1":/:}"
  PATH="${PATH#:}"
  PATH="$1:${PATH%:}"
}

# Homebrew first, so the PATH entries below still win over it
case "$OSTYPE" in
  darwin*)
    if [ -x /opt/homebrew/bin/brew ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x /usr/local/bin/brew ]; then
      eval "$(/usr/local/bin/brew shellenv)"
    fi
    ;;
esac

# Last one prepended comes first
path_prepend "$HOME/.cargo/bin"
path_prepend "$HOME/.grok/bin"
path_prepend "$HOME/.dotfiles/bin"
path_prepend "$HOME/bin"
path_prepend "$HOME/.local/bin"
export PATH

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
  export VISUAL='nvim'
fi

# Machine-local overrides, not tracked
if [ -f "$HOME/.profile-tmp" ]; then
    . "$HOME/.profile-tmp"
fi

alias nv="nvim ."

alias fast="fastfetch"

case "$OSTYPE" in
  darwin*)
    alias l="ls -alG"
    alias ls="ls -G"
    alias up="brew update && brew upgrade"
    ;;
  *)
    alias l="ls -al --color=auto"
    alias ls="ls --color=auto"
    alias up="paru -Syu"
    ;;
esac

# claude remote-control: give each session started from the app its own git
# worktree. There is no settings.json key for this, only the --spawn flag.
# Left alone outside a git repo (worktree mode errors there) and when the
# invocation picks its own mode or reattaches to an existing session.
claude() {
  if [ "$1" = "remote-control" ] && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    case " $* " in
      *" --spawn"*|*" --session-id"*|*" --continue "*|*" -c "*|*" --help "*|*" -h "*) ;;
      *) shift; set -- remote-control --spawn=worktree "$@" ;;
    esac
  fi
  command claude "$@"
}

# fzf colors
export FZF_DEFAULT_OPTS="\
--color=fg:#c0caf5,bg:#1a1b26,hl:#ff9e64 \
--color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"
