# debian

```
apt-get update -qq && apt-get upgrade -y -qq && apt-get install -y -qq git
git clone https://github.com/mhebbel2/base.git
time ./base/debian-sudo.sh
```

# termux

```
termux-setup-storage
pkg update -qq && pkg upgrade -y -qq
pkg install -yy openssh git bash-completion keychain termux-services x11-repo keepassxc
curl -fsSL https://raw.githubusercontent.com/DevCoreXOfficial/core-termux/main/install.sh | bash
core install lang --nodejs
core install dev --openssh --fzf
core install editor --neovim
core install ai --opencode
git clone https://github.com/mhebbel2/base.git
```

