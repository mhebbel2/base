# debian

```
apt-get update -qq && apt-get upgrade -y -qq && apt-get install -y -qq git
git clone --depth 1 https://github.com/mhebbel2/base.git
./base/debian-sudo.sh
```


# termux

```
pkg install -y openssh git gnupg
git clone --depth 1 https://github.com/mhebbel2/base.git
./base/termux.sh
```


