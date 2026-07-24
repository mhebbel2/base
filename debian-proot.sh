#!/bin/bash
#
# Run inside proot (termux proot-session)
#
export DEBIAN_FRONTEND=noninteractive

INSTALL_OPTS="-y -qq --no-install-recommends"

PACKAGES="git dtach fzf bash-completion ripgrep fd-find jq python3-pip python3.13-venv pipx rclone keychain keepassxc-minimal build-essential lsof sshfs"
RDP_DESKTOP="xfce4 xfce4-goodies xrdp chromium copyq"

apt-get $INSTALL_OPTS update
apt-get $INSTALL_OPTS install $PACKAGES
apt-get $INSTALL_OPTS install $RDP_DESKTOP

# --- create user
useradd -m -G sudo --create-home -s /bin/bash user

cp -r .ssh /home/user/
mkdir -p /home/user/projects
cp -r /root/base /home/user/projects
chown -R user /home/user

su - user /home/user/projects/base/user.sh
