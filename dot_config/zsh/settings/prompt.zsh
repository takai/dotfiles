# Cache ghq root via one-shot precmd (ghq may not be in PATH yet at source time)
_prompt_init_ghq_root() {
  _prompt_ghq_root="$(ghq root 2>/dev/null)"
  precmd_functions=(${precmd_functions:#_prompt_init_ghq_root})
}
precmd_functions+=(_prompt_init_ghq_root)

prompt_lime_render() {
  local repo_name="${vcs_info_msg_1_#x}"
  if [[ -n "$_prompt_ghq_root" && "$PWD" == "${_prompt_ghq_root}"/* && -n "$repo_name" ]]; then
    local prompt_color="${LIME_DIR_COLOR:-$prompt_lime_default_dir_color}"
    echo -n "%F{${prompt_color}}${repo_name}%f"
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
