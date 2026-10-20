autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '✚'
zstyle ':vcs_info:*' unstagedstr '●'
zstyle ':vcs_info:*' formats '%b%u%c'
ak_shorten_path() {
  local p="${PWD/#$HOME/~}"; local max="${AK_PROMPT_PATH_MAX_LEN:-25}"
  if (( ${#p} > max )); then print -rn -- "…${p[ -$((max-1)), -1 ]}"; else print -rn -- "$p"; fi
}
ak_vcs_prompt_hook() { vcs_info }
ak_build_prompt() {
  local last_exit=$?
  local c_primary="${AK_COLOR_PRIMARY:-cyan}"; local c_success="${AK_COLOR_SUCCESS:-green}"; local c_error="${AK_COLOR_ERROR:-red}"
  local c_dim="${AK_COLOR_DIM:-240}"; local sym="${AK_PROMPT_SYMBOL:-❯}"; local reset='%f'
  local user_name="%n"; [[ -n "${AK_CUSTOM_USER:-}" ]] && user_name="${AK_CUSTOM_USER}"
  local user_seg="%F{$c_primary}${user_name}${reset}"; local dir_seg="%F{$c_success}$(ak_shorten_path)${reset}"
  local git_seg=""; [[ -n "${vcs_info_msg_0_:-}" ]] && git_seg=" %F{$c_primary}(${vcs_info_msg_0_})${reset}"
  local status_color="%F{$c_success}"; (( last_exit != 0 )) && status_color="%F{$c_error}"
  PROMPT="${user_seg} ${dir_seg}${git_seg}\n${status_color}${sym}${reset} "; RPROMPT=""
}
autoload -Uz add-zsh-hook; add-zsh-hook precmd ak_vcs_prompt_hook; add-zsh-hook precmd ak_build_prompt
