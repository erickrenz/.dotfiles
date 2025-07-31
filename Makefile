all: bin dirs zsh nvim tmux starship

.PHONY: bin
bin:
	brew update
	brew upgrade
	brew bundle --file=~/.dotfiles/Brewfile # --force cleanup 
	@if  [ ! -d $(HOME)/.cargo/ ] ; then \
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y; \
		. "$(HOME)/.cargo/env"; \
	fi

.PHONY: dirs
dirs:
	mkdir -p $(HOME)/.config
	mkdir -p $(HOME)/code

.PHONY: zsh
zsh:
	@if [ -f $(HOME)/.zshrc ] && ! [ -L $(HOME)/.zshrc ]; then \
		mv $(HOME)/.zshrc $(HOME)/.zshrc.pre-dotfiles; \
	fi;
	ln -sf $(HOME)/.dotfiles/.zshrc $(HOME)/.zshrc

.PHONY: nvim
nvim:
	@if [ -d $(HOME)/.config/nvim ] && ! [ -L $(HOME)/.config/nvim ]; then \
		mv $(HOME)/.config/nvim $(HOME)/.config/.nvim.pre-dotfiles; \
	elif [ -d $(HOME)/.config/nvim ];  then \
		rm -rf $(HOME)/.config/nvim; \
	fi; 
	ln -sf $(HOME)/.dotfiles/nvim $(HOME)/.config/nvim 

.PHONY: tmux
tmux:
	ln -sf $(HOME)/.dotfiles/.tmux.conf $(HOME)/.tmux.conf

.PHONY: starship
starship:
	ln -sf $(HOME)/.dotfiles/starship.toml $(HOME)/.config/starship.toml
