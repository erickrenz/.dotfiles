#!/bin/zsh

if [[ ! -e /usr/local/bin/brew ]]; then
    echo "Error: this script must be run on a Mac with Homebrew installed."
    exit
fi

echo "[1/3] Updating packages..."

brew update
brew upgrade 

if ! brew ls --versions git > /dev/null; then
    brew install git
fi

echo "[2/3] Downloading repository..."

if  [ ! -d $HOME/.dotfiles/ ] ; then
    cd $HOME
    git clone https://github.com/erickrenz/.dotfiles.git
fi

cd $HOME/.dotfiles
git pull

echo "[3/3] Execute setup scripts..."

brew bundle --file=~/.dotfiles/Brewfile # --force cleanup 

if  [ ! -d $HOME/.cargo/ ] ; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

mkdir -p $HOME/.config
mkdir -p $HOME/code

ln -sf $HOME/.dotfiles/.zshrc $HOME/.zshrc
ln -sf $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf
ln -sf $HOME/.dotfiles/nvim $HOME/.config/nvim
ln -sf $HOME/.dotfiles/starship.toml $HOME/.config/starship.toml

echo "[DONE] Device setup complete!"
