# .zshenv

# Plain `ssh host cmd` runs non-login, non-interactive zsh, which reads only
# this file. Login and interactive shells load .profile from .zprofile/.zshrc.
if [[ ! -o login && ! -o interactive ]]; then
  source "$HOME/.profile"
fi
