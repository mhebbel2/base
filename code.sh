#!/bin/bash
# install and run the code server
# runs on debian or proot-distro on termux
if [[ -z $TERMUX ]];
then
	curl -fsSL https://code-server.dev/install.sh | sh
else
	pkg install tur-repo code-server
fi

# code extensions
code-server --install-extension jebbs.plantuml
code-server --install-extension asvetliakov.vscode-neovim
code-server --install-extension ms-python.debugpy
code-server --install-extension ms-python.python
code-server --install-extension ms-toolsai.jupyter
code-server --install-extension ms-toolsai.jupyter-keymap
code-server --install-extension ms-toolsai.jupyter-renderers
code-server --install-extension ms-toolsai.vscode-jupyter-cell-tags
code-server --install-extension ms-toolsai.vscode-jupyter-slideshow

