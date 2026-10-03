# .profile

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
  export VISUAL='nvim'
fi

# Source global definitions
if [ -f /home/ekrenz/.profile-tmp ]; then
    . /home/ekrenz/.profile-tmp
fi

alias nv="nvim ."

alias l="ls -al --color=auto"
alias ls="ls --color=auto"
alias fast="fastfetch"
alias up="sudo pacman -Syu"

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
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=fg:#c0caf5,bg:#1a1b26,hl:#ff9e64 \
--color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"

# dotfiles bin
export PATH="$HOME/.dotfiles/bin:$PATH"
