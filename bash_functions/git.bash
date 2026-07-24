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
