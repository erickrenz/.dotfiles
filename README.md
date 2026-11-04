# .dotfiles

## Quick Start
```bash
git clone https://github.com/erickrenz/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles && make
```

`make` checks `uname -s` and runs the right setup for the OS:

- **Arch Linux**: installs `packages.txt` with pacman and `packages-aur.txt` with
  paru, then links the shared configs plus sway, waybar, rofi and the system files.
- **macOS**: installs Homebrew if it is missing, installs the `Brewfile` with
  `brew bundle`, installs rustup, then links the shared configs.

You can also run a single target, such as `make nvim` or `make brew`.

## Other Installs

```bash
curl -fsSL https://herdr.dev/install.sh | sh                    # herdr
curl -fsSL https://claude.ai/install.sh | bash                  # claude
curl -fsSL https://x.ai/cli/install.sh | bash                   # grok || agent
curl https://cursor.com/install -fsS | bash                     # cursor-agent
curl -fsSL https://antigravity.google/cli/install.sh | bash     # agy
curl -fsSL https://t3.codes/install.sh | sh                     # t3
```
