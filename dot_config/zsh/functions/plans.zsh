# Zsh function to list, preview, copy, and edit Claude plans using fzf
plans() {
  local plan_dir="$HOME/.claude/plans"
  
  # Ensure the directory exists
  [[ ! -d "$plan_dir" ]] && echo "Error: $plan_dir not found." && return 1

  # Automatically select the clipboard command based on the OS/environment
  local copy_cmd
  if [[ "$OSTYPE" == "darwin"* ]]; then
    copy_cmd="pbcopy"
  elif (( $+commands[wl-copy] )); then
    copy_cmd="wl-copy"
  elif (( $+commands[clip.exe] )); then
    copy_cmd="clip.exe"
  else
    copy_cmd="cat" 
  fi

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
    --header "ENTER: Copy to Clipboard / CTRL-E: Edit" \
    --preview "bat --color=always --style=numbers {}" \
    --preview-window "right:60%:wrap" \
    --bind "ctrl-e:execute(${EDITOR:-vim} {})+abort"
  )

  # Handle the selection (if Enter was pressed)
  if [[ -n "$selected_file" ]]; then
    cat "$selected_file" | eval "$copy_cmd"
    echo "✅ Copied the content of $(basename "$selected_file") to clipboard."
  fi
}
