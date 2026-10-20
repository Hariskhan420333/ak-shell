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
  local reset='%f'
  local sym="${AK_PROMPT_SYMBOL:-❯}"
  
  # Username clean karo
  local user_name="%n"
  if [[ -n "${AK_CUSTOM_USER:-}" ]]; then
    user_name="${AK_CUSTOM_USER//[^a-zA-Z0-9_@-]/}" 
  fi
  
  # HARDCODED COLORS (Taake theme load fail ho toh bhi colors dikhein)
  local user_seg="%B%F{cyan}${user_name}%f%b"
  local dir_seg="%F{green}$(ak_shorten_path)${reset}"
  local git_seg=""
  
  if [[ -n "${vcs_info_msg_0_:-}" ]]; then
    git_seg=" %F{magenta}(${vcs_info_msg_0_})${reset}"
  fi
  
  local status_color="%F{green}"
  if (( last_exit != 0 )); then
    status_color="%F{red}"
  fi
  
  PROMPT="${user_seg} ${dir_seg}${git_seg}"$'\n'"${status_color}${sym}${reset} "; RPROMPT=""
}

autoload -Uz add-zsh-hook; add-zsh-hook precmd ak_vcs_prompt_hook; add-zsh-hook precmd ak_build_prompt
