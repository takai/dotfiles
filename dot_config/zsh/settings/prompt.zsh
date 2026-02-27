# Muted pastel palette for repo background colors (256-color codes)
_prompt_repo_palette=(60 66 67 95 96 101 103 108 130 131 132 136 137 138 139 167)

_prompt_repo_bg_color() {
  local name="$1"
  local hash=$(echo -n "$name" | cksum | cut -d' ' -f1)
  local idx=$((hash % ${#_prompt_repo_palette} + 1))
  echo -n "${_prompt_repo_palette[$idx]}"
}

# Cache ghq root via one-shot precmd (ghq may not be in PATH yet at source time)
_prompt_init_ghq_root() {
  _prompt_ghq_root="$(ghq root 2>/dev/null)"
  precmd_functions=(${precmd_functions:#_prompt_init_ghq_root})
}
precmd_functions+=(_prompt_init_ghq_root)

prompt_lime_render() {
  local repo_name="${vcs_info_msg_1_#x}"
  if [[ -n "$_prompt_ghq_root" && "$PWD" == "${_prompt_ghq_root}"/* && -n "$repo_name" ]]; then
    if [[ "$TERM" = *"256color" ]]; then
      local bg_color=$(_prompt_repo_bg_color "$repo_name")
      echo -n "%F{15}%K{${bg_color}}${repo_name}%k%F{${bg_color}}\ue0b0%f"
    else
      local prompt_color="${LIME_DIR_COLOR:-$prompt_lime_default_dir_color}"
      echo -n "%F{${prompt_color}}${repo_name}%f"
    fi
    echo -n ' '
    prompt_lime_git
    echo -n "${prompt_lime_rendered_symbol}"
    return
  fi
  echo -n "${prompt_lime_rendered_user}"
  echo -n ' '
  prompt_lime_dir
  echo -n ' '
  prompt_lime_git
  echo -n "${prompt_lime_rendered_symbol}"
}
