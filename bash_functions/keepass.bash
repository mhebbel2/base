function keepass-setup() {
	keepassxc-cli ls $HOME/stuff > $HOME/.pass.list
}
export -f keepass-setup

function kpt() {
	if [ -z "$1" ]; then
	  QUERY=""
	else
	  QUERY="-q $1"
	fi
	PASS=$(cat $HOME/.pass.list | fzf --select-1 $QUERY)
	TOTP=$(keepassxc-cli show --totp $HOME/stuff "$PASS")
	echo $TOTP
	tmux set-buffer "$TOTP"
}
export -f kpt
