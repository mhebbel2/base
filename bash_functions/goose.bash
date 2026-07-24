function gsh() {
	local name=$1
	eval "$(goose term init bash --name $name)"
}
export -f gsh