DOTFILES ?= $(CURDIR)

# $(call link,path-in-repo,destination): symlink a user config into place.
# A real file or directory already there is moved aside, not deleted.
define link
	@mkdir -p $(dir $(2))
	@if [ -e $(2) ] && [ ! -L $(2) ]; then \
		mv $(2) $(2).bak.$$(date +%s) && echo "backed up $(2)"; \
	fi
	ln -sfn $(DOTFILES)/$(1) $(2)
endef

# $(call install_root,path-in-repo,destination): copy a system file into place.
# Copied, never linked: a root-owned link into $HOME lets anything running as
# this user rewrite root's config. Re-run the target after editing the source.
define install_root
	sudo install -Dm644 -o root -g root $(DOTFILES)/$(1) $(2)
endef

.PHONY: all
all: pacman makepkg_config rustup paru bash dirs \
	sway swaylock rofi waybar \
	nvim tmux git_config starship \
	ghostty alacritty herdr claude \
	fontconfig ufw ssh_config

.PHONY: pacman_config
pacman_config:
	$(call install_root,etc/pacman.conf,/etc/pacman.conf)

.PHONY: pacman
pacman: pacman_config
	sudo pacman -Syu --needed - < packages.txt

.PHONY: makepkg_config
makepkg_config:
	$(call link,.config/pacman/makepkg.conf,$(HOME)/.config/pacman/makepkg.conf)

# paru updates itself through `paru -Syu`, so only bootstrap it when missing
.PHONY: paru
paru: pacman rustup makepkg_config
	@command -v paru >/dev/null || { \
		tmp=$$(mktemp -d) && \
		git clone https://aur.archlinux.org/paru.git $$tmp/paru && \
		(cd $$tmp/paru && makepkg -si); \
		status=$$?; rm -rf $$tmp; exit $$status; \
	}
	paru -S --needed - < packages-aur.txt

.PHONY: rustup
rustup: pacman
	rustup default stable

.PHONY: bash
bash:
	$(call link,.config/bash/.bash_profile,$(HOME)/.bash_profile)
	$(call link,.config/bash/.bashrc,$(HOME)/.bashrc)
	$(call link,.config/bash/.profile,$(HOME)/.profile)
	$(call link,.config/bash/.zshrc,$(HOME)/.zshrc)

.PHONY: dirs
dirs:
	mkdir -p $(HOME)/.config
	mkdir -p $(HOME)/code

.PHONY: swaylock
swaylock:
	$(call link,.config/swaylock,$(HOME)/.config/swaylock)

.PHONY: sway
sway:
	$(call link,.config/sway,$(HOME)/.config/sway)

.PHONY: rofi
rofi:
	$(call link,.config/rofi,$(HOME)/.config/rofi)

.PHONY: waybar
waybar:
	$(call link,.config/waybar,$(HOME)/.config/waybar)

.PHONY: nvim
nvim:
	$(call link,.config/nvim,$(HOME)/.config/nvim)

.PHONY: tmux
tmux:
	$(call link,.config/.tmux.conf,$(HOME)/.tmux.conf)

.PHONY: git_config
git_config:
	$(call link,.config/.gitconfig,$(HOME)/.gitconfig)

.PHONY: starship
starship:
	$(call link,.config/starship.toml,$(HOME)/.config/starship.toml)

.PHONY: ghostty
ghostty:
	$(call link,.config/ghostty,$(HOME)/.config/ghostty)

.PHONY: alacritty
alacritty:
	$(call link,.config/alacritty,$(HOME)/.config/alacritty)

.PHONY: fontconfig
fontconfig:
	$(call link,.config/fontconfig,$(HOME)/.config/fontconfig)
	fc-cache -f

.PHONY: herdr
herdr:
	$(call link,.config/herdr/config.toml,$(HOME)/.config/herdr/config.toml)

.PHONY: claude
claude:
	$(call link,.config/claude/settings.json,$(HOME)/.claude/settings.json)
	$(call link,.config/claude/statusline.sh,$(HOME)/.claude/statusline.sh)

.PHONY: ufw
ufw:
	sudo systemctl enable ufw
	sudo ufw default deny incoming
	sudo ufw default allow outgoing
	sudo ufw allow in on tailscale0 to any port 22 proto tcp
	sudo ufw allow 41641/udp
	sudo ufw --force enable
	sudo ufw status verbose

# The 10- prefix sorts before Arch's 99-archlinux.conf; sshd keeps the first
# value it reads for each option.
.PHONY: ssh_config
ssh_config:
	sudo rm -f /etc/ssh/sshd_config.d/disable-passwords.conf
	$(call install_root,etc/ssh.conf,/etc/ssh/sshd_config.d/10-disable-passwords.conf)
	sudo sshd -t
	sudo systemctl enable sshd
	sudo systemctl restart sshd

.PHONY: server
server:
	DOTFILES=$(DOTFILES) ./scripts/setup-server.sh
