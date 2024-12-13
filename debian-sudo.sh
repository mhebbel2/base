# !/bin/bash
#
export DEBIAN_FRONTEND=noninteractive
apt-get -y -qq update
apt-get -y -qq upgrade 
#
# ---
sed -i 's/#AllowAgentForwarding yes/AllowAgentForwarding yes/g' /etc/ssh/sshd_config && systemctl restart sshd
#echo fs.inotify.max_user_watches=524288 |  tee -a /etc/sysctl.conf &&  sysctl -p

#--- Docker
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
	$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
	tee /etc/apt/sources.list.d/docker.list > /dev/null
#--- node 
curl -fsSL https://deb.nodesource.com/setup_20.x -o nodesource_setup.sh
bash nodesource_setup.sh >/dev/null
#--- gh cli
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg |  dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" |  tee /etc/apt/sources.list.d/github-cli.list > /dev/null
#--- Now Install
PACKAGES="git mosh tmux bash-completion ripgrep build-essential jq htop zip unzip fzf bat cmake gh nodejs"
SPECIFIC_DEBIAN="python3-pip python3-neovim fd-find"
DOCKER="uidmap docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"

apt-get -y -qq install $PACKAGES $SPECIFIC_DEBIAN $DOCKER >/dev/null

npm install -s -g typescript bash-language-server typescript-language-server 

# --- create user
useradd -G sudo --create-home -s /bin/bash user 
usermod -aG docker user
