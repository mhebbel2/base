#!/bin/bash

function repo_clone() {
	if [ -f "$HOME/projects/dev/gh_users.txt" ]; then
		options=()
		while IFS= read -r line; do
			[ -z "$line" ] && continue
			options+=("$line")
		done < "$HOME/projects/dev/gh_users.txt"
	else
		options=("mhebbel2")
	fi
	USERID=$(printf '%s\n' "${options[@]}" | fzf)

	if [ -n "$USERID" ]; then
		REPO=$(gh repo list --json nameWithOwner --jq '.[].nameWithOwner' -L 300 $USERID |fzf)
		if [ -n "$REPO" ]; then
			NAMEOFREPO=$(basename $REPO)
			# git clone git@github.com:${REPO}.git $PROJECTS/$NAMEOFREPO
			gh repo clone $REPO $PROJECTS/$NAMEOFREPO
			cd $PROJECTS/$NAMEOFREPO
		fi
	fi
}
export -f repo_clone

function project_choose() {
	mkdir -p $PROJECTS
	if [ -z "$1" ]; then
	  QUERY=""
	else
	  QUERY="-q $1"
	fi
	options=( "_ _clone" )
	for dir in "$PROJECTS"/*; do
		if [ -d "$dir" ]; then
			if [ -d "$dir/.git" ]; then
				git_count=$(git -C "$dir" status -s | wc -l)
				if [ "$git_count" -gt 0 ]; then
					options+=( "+ $(basename "$dir")" )
				else
					branch_name=$(git -C "$dir" branch --show-current)
					git_push_count=$(git -C "$dir" rev-list --count origin/$branch_name..$branch_name)
					if [ "$git_push_count" -gt 0 ]; then
						options+=( "$git_push_count $(basename "$dir")" )
					else
						options+=( ". $(basename "$dir")" )
					fi
				fi
			else
				options+=( "! $(basename "$dir")" )
			fi
		fi
	done
	PROJ=$(printf '%b\n' "${options[@]}" | fzf --select-1 $QUERY  | awk '{print $2}')
	if [ -n "$PROJ" ]; then
	      if [ "$PROJ" == "_clone" ]; then 
	              repo_clone
	      else
	              cd $PROJECTS/$PROJ
	      fi
	      echo $PWD
		  echo Branch: $(git branch --show-current)
	fi
}
alias jp=project_choose
export -f project_choose
