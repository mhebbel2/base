 #!/bin/bash
 # run as root

 # Define variables
 REPO_URL="https://github.com/neovim/neovim.git"
 CLONE_DIR="$HOME/neovim"
 BUILD_DIR="$CLONE_DIR/build"

 # Update and install dependencies
apt-get update
apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen

 # Clone the Neovim repository
 if [ -d "$CLONE_DIR" ]; then
     echo "Directory $CLONE_DIR already exists. Pulling latest changes."
     cd "$CLONE_DIR" && git pull
 else
     echo "Cloning Neovim repository."
     git clone "$REPO_URL" "$CLONE_DIR"
 fi

 # Checkout the latest stable release
 cd "$CLONE_DIR"
 git checkout stable

 # Build Neovim
 make CMAKE_BUILD_TYPE=Release

 # Install Neovim
 make install

 # Verify installation
 nvim --version

 echo "Neovim installation completed successfully."

