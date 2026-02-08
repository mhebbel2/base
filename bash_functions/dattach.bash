dattach() {
    local session_name=$1
	local session_short_name="${session_name##*/}"
	local SLOG=$HOME/session_logs/$session_short_name.log
	dtach -A $session_name bash -c "export SESSION_LOG=$SLOG; script -f -q -a $SLOG"
}

alias da='dattach'
