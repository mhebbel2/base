export SESSION_DIR=$HOME/sessions
SESSION_LOGS=$HOME/session_logs
mkdir -p $SESSION_DIR
mkdir -p $SESSION_LOGS

dattach() {
	if [ -n "$SESSION_LOG" ]; then
		echo "You are already in a session. Please detach first."
		return 1
	fi
	if [ -z "$1" ]; then
	  QUERY=""
	else
	  QUERY="-q $1"
	fi
	local options=("_new")
	while IFS= read -r line; do
		options+=("$line")
	done < <(ls "$SESSION_DIR")

	local session_name=$( printf '%s\n' "${options[@]}" | fzf --select-1 $QUERY)

	if [ "$session_name" = "_new" ]; then
		read -p "Enter new session name: " new_session_name
		session_name=$new_session_name
	fi

	local SLOG=$SESSION_LOGS/$session_name.log
	dtach -A $SESSION_DIR/$session_name bash -c "export SESSION_LOG=$SLOG; script -f -q -a $SLOG"
}

gsl() {
	if [ -z "$SESSION_LOG" ]; then
		echo "SESSION_LOG is not set"
		return 1
	fi
	echo "$SESSION_LOG"
}

alias da='dattach'
alias gsl='gsl'
