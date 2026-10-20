if [[ -n "${AK_SHELL_LOADED:-}" ]]; then return 0; fi
typeset -g AK_SHELL_LOADED=1
AK_SHELL_ROOT="${${(%):-%x}:A:h:h}"
export AK_SHELL_ROOT
[[ -f "${AK_SHELL_CONFIG_DIR:-$HOME/.config/ak-shell}/settings" ]] && source "${AK_SHELL_CONFIG_DIR:-$HOME/.config/ak-shell}/settings"
source "${AK_SHELL_ROOT}/config/defaults.zsh"
source "${AK_SHELL_ROOT}/core/history.zsh"
source "${AK_SHELL_ROOT}/core/theme-engine.zsh"
source "${AK_SHELL_ROOT}/core/prompt.zsh"
[[ -f "$HOME/.config/ak-shell/user" ]] && source "$HOME/.config/ak-shell/user"
if [[ $- == *i* ]]; then source "${AK_SHELL_ROOT}/core/completion.zsh"; source "${AK_SHELL_ROOT}/core/loader.zsh"; fi

# BANNER LOGIC FIXED
if [[ $- == *i* ]] && [[ "${AK_ENABLE_BANNER:-true}" == "true" ]]; then
  if [[ -f "$HOME/.config/ak-shell/banner.txt" ]]; then
    while IFS= read -r line; do echo -e "$line"; done < "$HOME/.config/ak-shell/banner.txt"
  elif [[ -f "${AK_SHELL_ROOT}/assets/banner.txt" ]]; then
    while IFS= read -r line; do echo -e "$line"; done < "${AK_SHELL_ROOT}/assets/banner.txt"
  fi
fi
export AK_SHELL_READY=1
