all: dirs nvim tmux starship

.PHONY: dirs
dirs:
	mkdir -p $(HOME)/.config
	mkdir -p $(HOME)/code

.PHONY: nvim
nvim:
	@if [ -d $(HOME)/.config/nvim ] && ! [ -L $(HOME)/.config/nvim ]; then \
		mv $(HOME)/.config/nvim $(HOME)/.config/.nvim.pre-dotfiles; \
	elif [ -d $(HOME)/.config/nvim ];  then \
		rm -rf $(HOME)/.config/nvim; \
	fi; 
	ln -sf $(HOME)/.dotfiles/.config/nvim $(HOME)/.config/nvim 

.PHONY: tmux
tmux:
	ln -sf $(HOME)/.dotfiles/.config/.tmux.conf $(HOME)/.tmux.conf

.PHONY: starship
starship:
	ln -sf $(HOME)/.dotfiles/.config/starship.toml $(HOME)/.config/starship.toml
