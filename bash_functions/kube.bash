function kc() {
	if [ -z "$1" ]; then
	  QUERY=""
	else
	  QUERY="-q $1"
	fi
	CONTEXT=$(kubectl config get-contexts | sed 's/\*//' | awk '!/CURRENT/{print$1}' | fzf --select-1 $QUERY)
	kubectl config use-context $CONTEXT
	kubectl config set-context --current --namespace=default
}
export -f kc

function kns() {
	if [ -z "$1" ]; then
	  QUERY=""
	else
	  QUERY="-q $1"
	fi
	NAMESPACE=$(kubectl get ns | sed 's/\*//' | awk '!/NAME/{print$1}' | fzf --select-1 $QUERY)
	kubectl config set-context --current --namespace=$NAMESPACE
}
export -f kns

