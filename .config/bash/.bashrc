# .bashrc

# Shared environment, aliases and functions
source "$HOME/.profile"

# Everything below is for interactive shells only; ssh commands, scp and
# agent tool calls stop here.
[[ $- != *i* ]] && return

# History File
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=10000
# append instead of overwriting, so parallel tmux panes don't clobber history
shopt -s histappend

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# tmux sessionizer
bind -x '"\C-f":tmux-sessionizer'

# starship
eval "$(starship init bash)"

# >>> grok installer >>>
[[ -r "$HOME/.grok/completions/bash/grok.bash" ]] && source "$HOME/.grok/completions/bash/grok.bash"
# <<< grok installer <<<
