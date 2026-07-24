#!/bin/bash
#
# Run on real root device (not proot)
#
export DEBIAN_FRONTEND=noninteractive

#--- Docker
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
	$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
	tee /etc/apt/sources.list.d/docker.list > /dev/null

INSTALL_OPTS="-y -qq --no-install-recommends"

PACKAGES="wireguard"
DOCKER="uidmap docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"

apt-get $INSTALL_OPTS update
apt-get $INSTALL_OPTS install $PACKAGES $DOCKER

# --- sysctl
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
