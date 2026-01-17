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

