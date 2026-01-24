KEEPASS_LIST="$HOME/.pass.list"

function keepass-setup() {
	keepassxc-cli ls $KEEPASS_DB > $KEEPASS_LIST
}
export -f keepass-setup

function kpt() {
	if [ -z "$1" ]; then
	  QUERY=""
	else
	  QUERY="-q $1"
	fi
	PASS=$(cat $KEEPASS_LIST | fzf --select-1 $QUERY)
	TOTP=$(keepassxc-cli show --totp $KEEPASS_DB "$PASS")
	echo $TOTP
	tmux set-buffer "$TOTP"
}
export -f kpt

ssh-load() {
    keepassxc-cli attachment-export "$KEEPASS_DB" "sshkeys" "$1" --stdout | ssh-add -
}
