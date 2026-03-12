# Zsh function to list, preview, copy, and edit Claude plans using fzf
plans() {
  local plan_dir="$HOME/.claude/plans"
  
  # Ensure the directory exists
  [[ ! -d "$plan_dir" ]] && echo "Error: $plan_dir not found." && return 1

  # Use Zsh glob qualifiers:
  # (N): null_glob (don't error if no match)
  # (.): match regular files only
  # (om): order by modification time (newest first)
  local files=($plan_dir/*.md(N.om))

  if (( ${#files} == 0 )); then
    echo "No plan files found in $plan_dir"
    return 1
  fi

  local selected_file
  # Launch fzf
  selected_file=$(printf "%s\n" "${files[@]}" | fzf \
    --height 80% \
    --reverse \
    --border \
    --prompt "Claude Plans (Recent first) > " \
    --header "ENTER: Open / CTRL-E: Edit" \
    --preview "bat --color=always --style=numbers {}" \
    --preview-window "right:60%:wrap" \
    --bind "ctrl-e:execute(${EDITOR:-vim} {})+abort"
  )

  # Handle the selection (if Enter was pressed)
  if [[ -n "$selected_file" ]]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
      open "$selected_file"
    else
      xdg-open "$selected_file"
    fi
  fi
}
