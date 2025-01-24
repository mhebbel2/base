#!/bin/bash
# install and run the code server
# runs on debian or proot-distro on termux
if [[ -z $TERMUX ]];
then
	curl -fsSL https://code-server.dev/install.sh | sh
else
	pkg install tur-repo
	pkg install code-server
fi

# code extensions
code-server --force --install-extension jebbs.plantuml
code-server --force --install-extension asvetliakov.vscode-neovim
code-server --force --install-extension ms-python.debugpy
code-server --force --install-extension ms-python.python
code-server --force --install-extension ms-toolsai.jupyter
code-server --force --install-extension ms-toolsai.jupyter-keymap
code-server --force --install-extension ms-toolsai.jupyter-renderers
code-server --force --install-extension ms-toolsai.vscode-jupyter-cell-tags
code-server --force --install-extension ms-toolsai.vscode-jupyter-slideshow

