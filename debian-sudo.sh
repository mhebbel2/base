# !/bin/bash
#
export DEBIAN_FRONTEND=noninteractive

#--- Now Install
# Use --no-install-recommends to skip optional bloat
INSTALL_OPTS="-y -qq --no-install-recommends"

PACKAGES="git dtach fzf ufw bash-completion ripgrep fd-find jq python3-pip python3.13-venv pipx rclone keychain keepassxc-minimal build-essential lsof sshfs"
RDP_DESKTOP="xfce4 xorgxrdp xfce4-goodies xrdp chromium copyq"

apt-get $INSTALL_OPTS update
apt-get $INSTALL_OPTS install $PACKAGES
apt-get $INSTALL_OPTS install $RDP_DESKTOP

# ---
cat <<EOF >> /etc/sysctl.conf
net.ipv4.ip_forward=1
fs.inotify.max_user_watches=524288
EOF
sysctl -p

# --- firewall
ufw default deny incoming
ufw limit OpenSSH
ufw --force enable

# --- create user
useradd -m -G sudo,docker --create-home -s /bin/bash user 
# sudo usermod -aG video,render $USER

cp -r .ssh /home/user/
mkdir -p /home/user/projects
cp -r /root/base /home/user/projects
chown -R user /home/user

su - user /home/user/projects/base/user.sh
