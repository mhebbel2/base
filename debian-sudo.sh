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

PACKAGES="git dtach fzf ufw fail2ban wireguard bash-completion ripgrep fd-find jq htop python3-pip python3.13-venv rclone keychain keepassxc-minimal"
DOCKER="uidmap docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"

apt-get $INSTALL_OPTS update
apt-get $INSTALL_OPTS install $PACKAGES $DOCKER

# Clean up apt cache immediately to save space
apt-get clean
rm -rf /var/lib/apt/lists/*
# ---
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
echo fs.inotify.max_user_watches=524288 |  tee -a /etc/sysctl.conf
sysctl -p
# localectl set-locale LANG=en_US.UTF-8

# --- firewall
ufw default deny incoming
ufw allow OpenSSH
ufw allow 51820
ufw --force enable

# --- create user
useradd -G sudo --create-home -s /bin/bash user 
usermod -aG docker user

cp -r .ssh /home/user/
mkdir -p /home/user/projects/
cp -r /root/base /home/user/projects

chown -R user /home/user

su - user /home/user/projects/base/debian-user.sh
