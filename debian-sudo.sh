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
PACKAGES="git tmux bash-completion ripgrep build-essential jq htop zip unzip bat cmake tree"
VNC="tigervnc-standalone-server tigervnc-common tigervnc-tools dbus-x11 xfce4 xfce4-terminal firefox-esr chromium ufw"
SPECIFIC_DEBIAN="python3-pip fd-find"
DOCKER="uidmap docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
SPECIFIC_NVIM="fuse libfuse2"

apt-get -y -qq update
apt-get -y -qq install $PACKAGES $VNC $SPECIFIC_DEBIAN $SPECIFIC_NVIM $DOCKER >/dev/null
# ---
sed -i '/^AcceptEnv/s/$/ *_TOKEN *_API_KEY/' /etc/ssh/sshd_config
sed -i 's/#AllowAgentForwarding yes/AllowAgentForwarding yes/g' /etc/ssh/sshd_config && systemctl restart sshd
echo fs.inotify.max_user_watches=524288 |  tee -a /etc/sysctl.conf &&  sysctl -p

# --- firewall

ufw default deny incoming
ufw allow OpenSSH
ufw enable

# --- create user
useradd -G sudo --create-home -s /bin/bash user 
usermod -aG docker user
addgroup fuse
usermod -aG fuse user

cp -r .ssh /home/user/
mkdir -p /home/user/projects/

cp /root/base/vncserver.service /etc/systemd/system/
systemctl enable vncserver.service
systemctl start vncserver.service

chown -R user /home/user

su - /root/base/debian-user.sh
