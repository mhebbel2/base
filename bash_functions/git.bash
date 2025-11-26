function branch() {
	BRANCHNAME=$1
	git checkout -b $BRANCHNAME
	git push origin $BRANCHNAME --set-upstream
}
export -f branch

