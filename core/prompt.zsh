# AK SHELL — Prompt engine (Phase 2 baseline)
# Phase 3 will refactor this to read colors from the active theme.

# ── Load vcs_info for git integration ──────────────────
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr   '✚'
zstyle ':vcs_info:*' unstagedstr '●'
zstyle ':vcs_info:*' formats       '%F{cyan}(%b%u%c)%f'
zstyle ':vcs_info:*' actionformats '%F{cyan}(%b|%a%u%c)%f'

# ── Helper: shorten path to fit small screens ──────────
ak_shorten_path() {
  local p="${PWD/#$HOME/~}"
  local max="${AK_PROMPT_PATH_MAX_LEN:-25}"
  if (( ${#p} > max )); then
    print -rn -- "…${p[ -$((max-1)), -1 ]}"
  else
    print -rn -- "$p"
  fi
}

# ── vcs_info hook ──────────────────────────────────────
ak_vcs_prompt_hook() {
  vcs_info
}

# ── Prompt builder ─────────────────────────────────────
ak_build_prompt() {
  # Capture exit code FIRST (before any other command runs).
  local last_exit=$?

  local reset='%f'
  local cyan='%F{cyan}'
  local green='%F{green}'
  local red='%F{red}'
  local dim='%F{240}'

  # ── Segments ─────────────────────────────────────────
  local user_seg=""
  local host_seg=""
  local dir_seg=""
  local git_seg=""
  local time_seg=""

  if [[ "${AK_PROMPT_SHOW_USER:-true}" == "true" ]]; then
    user_seg="${cyan}%n${reset}"
  fi

  if [[ "${AK_PROMPT_SHOW_HOST:-false}" == "true" ]]; then
    host_seg="${dim}@%m${reset}"
  fi

  dir_seg="${green}$(ak_shorten_path)${reset}"

  if [[ "${AK_PROMPT_SHOW_GIT:-true}" == "true" ]] && [[ -n "${vcs_info_msg_0_:-}" ]]; then
    git_seg=" ${vcs_info_msg_0_}"
  fi

  if [[ "${AK_PROMPT_SHOW_TIME:-false}" == "true" ]]; then
    time_seg=" ${dim}[%D{%H:%M}]${reset}"
  fi

  # ── Status character ─────────────────────────────────
  local status_char='%(!.#.>)'
  local status_color="${green}"
  (( last_exit != 0 )) && status_color="${red}"

  # ── Assemble ─────────────────────────────────────────
  case "${AK_PROMPT_MODE:-multiline}" in
    compact)
      PROMPT="${user_seg}${host_seg} ${dir_seg}${git_seg} ${status_color}${status_char}${reset} "
      ;;
    singleline)
      PROMPT="${user_seg}${host_seg} ${dir_seg}${git_seg}${time_seg} ${status_color}${status_char}${reset} "
      ;;
    multiline|*)
      PROMPT="${user_seg}${host_seg} ${dir_seg}${git_seg}${time_seg}
${status_color}${status_char}${reset} "
      ;;
  esac
  RPROMPT=""
}

# ── Wire into Zsh lifecycle ────────────────────────────
autoload -Uz add-zsh-hook
add-zsh-hook precmd ak_vcs_prompt_hook
add-zsh-hook precmd ak_build_prompt
