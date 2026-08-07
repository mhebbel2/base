function branch() {
	BRANCHNAME=$1
	git checkout -b $BRANCHNAME
	git push origin $BRANCHNAME --set-upstream
}
export -f branch

function github() {
	# local repo=$(gh repo list --no-archived --json sshUrl --jq '.[].sshUrl' -L 400 $1 |fzf)
	local repo=$(cat $HOME/.local/github_repos.txt | fzf)
	git -C $PROJECTS clone $repo
	cd $PROJECTS/$(basename $repo .git)
	pwd
	$PROJECTS/base/bin/set_git_config.sh
}

ssh-load() {
    keepassxc-cli show -s -a "$1" "$KEEPASS_DB" sshkeys | ssh-add -
}

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

