#!/bin/bash
set -e

BASEDIR=$HOME/projects/base
BINDIR=$HOME/.local/bin
mkdir -p $BINDIR
mkdir -p $HOME/.config/rclone
mkdir -p $HOME/.config/hcloud

ln -sf $BASEDIR/dotfiles/inputrc $HOME/.inputrc

echo "startxfce4" > ~/.xsession

mkdir -p $HOME/.config/nvim/
ln -sf $BASEDIR/dotfiles/init.lua $HOME/.config/nvim/init.lua

curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git config --global pull.rebase false
git config --global init.defaultBranch main

if [[ "$PREFIX" !=  *"/com.termux/"* ]]; then
	# Maps x86_64 -> amd64, aarch64 -> arm64
	ARCH=$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/')

	# --- get the right yq for debian (the standard one is strange) 
	curl -sL https://github.com/mikefarah/yq/releases/download/v4.45.4/yq_linux_$ARCH -o $BINDIR/yq && chmod +x $BINDIR/yq

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

touch $HOME/.bashrc
if ! grep -q "base/dotfiles/bashrc" $HOME/.bashrc; then
    echo "source ${BASEDIR}/dotfiles/bashrc" >> $HOME/.bashrc
fi
