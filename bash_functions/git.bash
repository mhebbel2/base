function branch() {
	BRANCHNAME=$1
	git checkout -b $BRANCHNAME
	git push origin $BRANCHNAME --set-upstream
}
export -f branch

function clone_repo() {
	local repo=$1
	git -C $PROJECTS clone $repo
	cd $PROJECTS/$(basename $repo .git)
	pwd
}

# function codeberg() {
# 	local repo=$(curl -sS -H "Authorization: token $CODEBERG_API_TOKEN"  "https://codeberg.org/api/v1/user/repos" | jq -r '.[] | "\(.ssh_url)"' | fzf)
# 	clone_repo "$repo"
# }
#
function github() {
	# local repo=$(gh repo list --no-archived --json sshUrl --jq '.[].sshUrl' -L 400 $1 |fzf)
	local repo=$(cat $HOME/.local/github_repos.txt | fzf)
	clone_repo "$repo"
	$PROJECTS/work/bin/set_git_config.sh
}
