# AK SHELL — Prompt engine
# Colors and symbols are injected by the theme engine.

# ── Load vcs_info for git integration ──────────────────
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr   '✚'
zstyle ':vcs_info:*' unstagedstr '●'
zstyle ':vcs_info:*' formats       '%b%u%c' # No colors here! Let prompt handle it.
zstyle ':vcs_info:*' actionformats '%b|%a%u%c'

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
  local last_exit=$?

  # ── Load theme variables (with fallbacks) ────────────
  local c_primary="${AK_COLOR_PRIMARY:-cyan}"
  local c_success="${AK_COLOR_SUCCESS:-green}"
  local c_error="${AK_COLOR_ERROR:-red}"
  local c_dim="${AK_COLOR_DIM:-240}"
  local sym="${AK_PROMPT_SYMBOL:-❯}"

  local reset='%f'
  local user_seg=""
  local host_seg=""
  local dir_seg=""
  local git_seg=""
  local time_seg=""

  if [[ "${AK_PROMPT_SHOW_USER:-true}" == "true" ]]; then
    user_seg="%F{$c_primary}%n${reset}"
  fi

  if [[ "${AK_PROMPT_SHOW_HOST:-false}" == "true" ]]; then
    host_seg="%F{$c_dim}@%m${reset}"
  fi

  dir_seg="%F{$c_success}$(ak_shorten_path)${reset}"

  if [[ "${AK_PROMPT_SHOW_GIT:-true}" == "true" ]] && [[ -n "${vcs_info_msg_0_:-}" ]]; then
    git_seg=" %F{$c_primary}(${vcs_info_msg_0_})${reset}"
  fi

  if [[ "${AK_PROMPT_SHOW_TIME:-false}" == "true" ]]; then
    time_seg=" %F{$c_dim}[%D{%H:%M}]${reset}"
  fi

  # ── Status character ─────────────────────────────────
  local status_color="%F{$c_success}"
  if (( last_exit != 0 )); then
    status_color="%F{$c_error}"
  fi

  # ── Assemble ─────────────────────────────────────────
  case "${AK_PROMPT_MODE:-multiline}" in
    compact)
      PROMPT="${user_seg}${host_seg} ${dir_seg}${git_seg} ${status_color}${sym}${reset} "
      ;;
    singleline)
      PROMPT="${user_seg}${host_seg} ${dir_seg}${git_seg}${time_seg} ${status_color}${sym}${reset} "
      ;;
    multiline|*)
      PROMPT="${user_seg}${host_seg} ${dir_seg}${git_seg}${time_seg}
${status_color}${sym}${reset} "
      ;;
  esac
  RPROMPT=""
}

# ── Wire into Zsh lifecycle ────────────────────────────
autoload -Uz add-zsh-hook
add-zsh-hook precmd ak_vcs_prompt_hook
add-zsh-hook precmd ak_build_prompt
