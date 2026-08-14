#!/bin/bash
set -e

BASEDIR=$HOME/projects/base
mkdir -p $HOME/.config/rclone
mkdir -p $HOME/.config/hcloud
ln -sf $BASEDIR/dotfiles/inputrc $HOME/.inputrc
mkdir -p $HOME/.config/nvim/
ln -sf $BASEDIR/dotfiles/init.lua $HOME/.config/nvim/init.lua

# curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    # https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git config --global pull.rebase false
git config --global init.defaultBranch main

cp $BASEDIR/dotfiles/profile $HOME/.profile

if [[ "$PREFIX" !=  *"/com.termux/"* ]]; then
	mkdir -p $BINDIR
	BINDIR=$HOME/.local/bin
    echo "startxfce4" > ~/.xsession

	# Maps x86_64 -> amd64, aarch64 -> arm64
	ARCH=$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/')

	# nvm/node/npm (not on termux)
	curl -s -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
	nvm install 20

	# opencode
	npm i -g opencode-ai

	# nvim
	curl -sSL "https://github.com/neovim/neovim/releases/download/v0.12.2/nvim-linux-x86_64.tar.gz" | tar -xz -C "$HOME/.local/" --strip-components=1
fi

