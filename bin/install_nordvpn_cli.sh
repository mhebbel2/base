sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
sudo groupadd nordvpn
sudo usermod -aG nordvpn user
nordvpn login --token $NORDVPN_TOKEN
nordvpn whitelist add port 22
nordvpn set analytics off
nordvpn status
