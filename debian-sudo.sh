# !/bin/bash
#
export DEBIAN_FRONTEND=noninteractive
# ---
sed -i '/^AcceptEnv/s/$/ *_TOKEN *_API_KEY/' /etc/ssh/sshd_config
sed -i 's/#AllowAgentForwarding yes/AllowAgentForwarding yes/g' /etc/ssh/sshd_config && systemctl restart sshd
#echo fs.inotify.max_user_watches=524288 |  tee -a /etc/sysctl.conf &&  sysctl -p

#--- Docker
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
	$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
	tee /etc/apt/sources.list.d/docker.list > /dev/null
#--- Now Install
PACKAGES="git tmux bash-completion ripgrep build-essential jq htop zip unzip bat cmake "
VNC="tigervnc-standalone-server tigervnc-common jwm"
SPECIFIC_DEBIAN="python3-pip fd-find"
DOCKER="uidmap docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
SPECIFIC_NVIM="fuse libfuse2"

apt-get -y -qq update
apt-get -y -qq install $PACKAGES $VNC $SPECIFIC_DEBIAN $SPECIFIC_NVIM $DOCKER >/dev/null

apt-get install -y -qq tigervnc-standalone-server tigervnc-common tigervnc-tools xfce4 xterm firefox-esr

# --- create user
useradd -G sudo --create-home -s /bin/bash user 
usermod -aG docker user
addgroup fuse
usermod -aG fuse user

cp -r .ssh /home/user/
mkdir -p /home/user/projects/
chown -R user /home/user
