all: pacman paru rustup bash dirs hypr sway swaylock rofi waybar nvim tmux starship ghostty alacritty

PHONY: pacman
pacman:
	sudo pacman -Syu --needed - < packages.txt

PHONY: paru
paru:
	@if [ -d "$(HOME)/paru" ]; then \
		cd $(HOME)/paru && git pull --rebase ; \
	else \
		git clone https://aur.archlinux.org/$(PKGNAME).git $(HOME)/paru/ ; \
	fi
	cd $(HOME)/paru && makepkg -si
	paru -S --needed - < packages-aur.txt

PHONY: rustup
rustup:
	rustup default stable

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

.PHONY: hypr
hypr:
	if [ -d $(HOME)/.config/hypr ];  then \
		rm -rf $(HOME)/.config/hypr; \
	fi;
	ln -sf $(HOME)/.dotfiles/.config/hypr $(HOME)/.config/hypr

.PHONY: swaylock
swaylock:
	if [ -d $(HOME)/.config/swaylock ];  then \
		rm -rf $(HOME)/.config/swaylock; \
	fi;
	ln -sf $(HOME)/.dotfiles/.config/swaylock $(HOME)/.config/swaylock

.PHONY: sway
sway:
	if [ -d $(HOME)/.config/sway ];  then \
		rm -rf $(HOME)/.config/sway; \
	fi;
	ln -sf $(HOME)/.dotfiles/.config/sway $(HOME)/.config/sway

.PHONY: rofi
rofi:
	if [ -d $(HOME)/.config/rofi ];  then \
		rm -rf $(HOME)/.config/rofi; \
	fi;
	ln -sf $(HOME)/.dotfiles/.config/rofi $(HOME)/.config/rofi

.PHONY: waybar
waybar:
	if [ -d $(HOME)/.config/waybar ];  then \
		rm -rf $(HOME)/.config/waybar; \
	fi;
	ln -sf $(HOME)/.dotfiles/.config/waybar $(HOME)/.config/waybar

.PHONY: nvim
nvim:
	if [ -d $(HOME)/.config/nvim ];  then \
		rm -rf $(HOME)/.config/nvim; \
	fi;
	ln -sf $(HOME)/.dotfiles/.config/nvim $(HOME)/.config/nvim 

.PHONY: tmux
tmux:
	ln -sf $(HOME)/.dotfiles/.config/.tmux.conf $(HOME)/.tmux.conf

.PHONY: starship
starship:
	ln -sf $(HOME)/.dotfiles/.config/starship.toml $(HOME)/.config/starship.toml

.PHONY: ghostty
ghostty:
	if [ -d $(HOME)/.config/ghostty ];  then \
		rm -rf $(HOME)/.config/ghostty; \
	fi;
	ln -sf $(HOME)/.dotfiles/.config/ghostty $(HOME)/.config/ghostty

.PHONY: alacritty
alacritty:
	if [ -d $(HOME)/.config/alacritty ];  then \
		rm -rf $(HOME)/.config/alacritty; \
	fi;
	ln -sf $(HOME)/.dotfiles/.config/alacritty $(HOME)/.config/alacritty
