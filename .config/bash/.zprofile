# .zprofile

# Login shells (tmux panes, `zsh -lc`). On macOS /etc/zprofile runs path_helper
# just before this and reorders PATH, so load .profile again to put it back.
source "$HOME/.profile"
