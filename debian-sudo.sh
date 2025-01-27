# !/bin/bash
#
export DEBIAN_FRONTEND=noninteractive
# ---
sed -i '/^AcceptEnv/s/$/ GH_TOKEN OPENAI_API_KEY/' /etc/ssh/sshd_config
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
PACKAGES="git mosh bash-completion ripgrep build-essential jq htop zip unzip bat cmake "
SPECIFIC_DEBIAN="python3-pip fd-find"
SPECIFIC_AIC="sqlite3"
DOCKER="uidmap docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
SPECIFIC_NVIM="fuse libfuse2"

apt-get -y -qq update
apt-get -y -qq install $PACKAGES $SPECIFIC_DEBIAN $SPECIFIC_AIC $SPECIFIC_NVIM $DOCKER >/dev/null

# --- create user
useradd -G sudo --create-home -s /bin/bash user 
usermod -aG docker user
addgroup fuse
usermod -aG fuse user

cp -r .ssh /home/user/
cp base/ssh-config /home/user/.ssh/
mkdir -p /home/user/projects/
chown -R user /home/user
