# v() {
#   if [ -n "$NVIM" ]; then
#     # We are inside an nvim terminal
#     nvim --server "$NVIM" --remote "$@"
#   else
#     # We are in a standard terminal
#     nvim "$@"
#   fi
# }
