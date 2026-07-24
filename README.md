# debian

```
apt-get update -qq && apt-get upgrade -y -qq && apt-get install -y -qq git
git clone https://github.com/mhebbel2/base.git
time ./base/debian-sudo.sh
```

# termux


Classic:
```
termux-setup-storage
pkg update -qq && pkg upgrade -y -qq
pkg install -yy openssh git 
pkg install bash-completion neovim fzf keychain termux-services x11-repo keepassxc
git clone https://github.com/mhebbel2/base.git
```

core-termux:
```
curl -fsSL https://raw.githubusercontent.com/DevCoreXOfficial/core-termux/main/install.sh | bash
```


