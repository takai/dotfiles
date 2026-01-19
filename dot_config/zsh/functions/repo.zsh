repo() {
  local query="$*"
  local dir

  dir=$(
    ghq list -p |
      fzf --prompt="repo> " \
          --height=70% --reverse \
          --query "$query" \
          --select-1 --exit-0
  ) || return

  [ -n "$dir" ] && cd "$dir"
}

# Completion function for repo command
_repo_completion() {
  local -a candidates
  # Store the list as an array
  candidates=("${(@f)$(ghq list)}")

  # Register completion candidates with the :t (tail) modifier
  # This extracts only the project name from each path
  compadd - "${(@)candidates:t}"
}

# Bind the completion function to the repo command
compdef _repo_completion repo
