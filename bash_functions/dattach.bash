dattach() {
    local session_name=$1
    if [ -z "$session_name" ]; then
        echo "Usage: dattach <session_name_with dir>"
        return 1
    fi
	local session_short_name="${session_name##*/}"
    dtach -A $session_name bash -c "export MY_SESSION='$session_short_name'; exec bash"
}

alias da='dattach'
