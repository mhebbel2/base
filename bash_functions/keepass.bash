ssh-load() {
    keepassxc-cli show -s -a "$1" "$KEEPASS_DB" sshkeys | ssh-add -
    # keepassxc-cli attachment-export "$KEEPASS_DB" "sshkeys" "$1" --stdout | ssh-add -
}
