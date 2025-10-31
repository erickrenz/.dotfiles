all: pacman bash dirs nvim tmux starship

PHONY: pacman
pacman:
	sudo pacman -Syu --needed - < packages.txt

.PHONY: bash
bash:
	ln -sf $(HOME)/.dotfiles/.config/bash/.bash_profile $(HOME)/.bash_profile
	ln -sf $(HOME)/.dotfiles/.config/bash/.bashrc $(HOME)/.bashrc
	ln -sf $(HOME)/.dotfiles/.config/bash/.profile $(HOME)/.profile
	ln -sf $(HOME)/.dotfiles/.config/bash/.zshrc $(HOME)/.zshrc

.PHONY: dirs
dirs:
	mkdir -p $(HOME)/.config
	mkdir -p $(HOME)/code

.PHONY: nvim
nvim:
	ln -sf $(HOME)/.dotfiles/.config/nvim $(HOME)/.config/nvim 

.PHONY: tmux
tmux:
	ln -sf $(HOME)/.dotfiles/.config/.tmux.conf $(HOME)/.tmux.conf

.PHONY: starship
starship:
	ln -sf $(HOME)/.dotfiles/.config/starship.toml $(HOME)/.config/starship.toml
