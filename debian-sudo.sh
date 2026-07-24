# !/bin/bash
#
export DEBIAN_FRONTEND=noninteractive

#--- Docker
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
	$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
	tee /etc/apt/sources.list.d/docker.list > /dev/null

#--- Now Install
# Use --no-install-recommends to skip optional bloat
INSTALL_OPTS="-y -qq --no-install-recommends"

PACKAGES="git dtach fzf ufw wireguard bash-completion ripgrep fd-find jq python3-pip python3.13-venv pipx rclone keychain keepassxc-minimal build-essential lsof sshfs"
DOCKER="uidmap docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
WAYLAND="sway wayvnc"
RDP_DESKTOP="xfce4 xfce4-goodies xrdp chromium copyq"

apt-get $INSTALL_OPTS update
apt-get $INSTALL_OPTS install $PACKAGES $DOCKER
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
ufw allow 51820 # Wireguard
ufw allow in on wg-dev to 10.99.0.1 from 10.99.0.2
ufw --force enable

# --- create user
useradd -m -G sudo,docker --create-home -s /bin/bash user 
# sudo usermod -aG video,render $USER

cp -r .ssh /home/user/
mkdir -p /home/user/projects
cp -r /root/base /home/user/projects
chown -R user /home/user

su - user /home/user/projects/base/user.sh
