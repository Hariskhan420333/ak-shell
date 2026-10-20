# AK SHELL — Main initialization
# This is the only file that should be sourced from ~/.zshrc.

# ── Guard: load only once per session ──────────────────
if [[ -n "${AK_SHELL_LOADED:-}" ]]; then
  return 0
fi
typeset -g AK_SHELL_LOADED=1

# ── Resolve AK SHELL root directory ────────────────────
AK_SHELL_ROOT="${${(%):-%x}:A:h:h}"
export AK_SHELL_ROOT

# ── User settings (overrides defaults) ─────────────────
if [[ -f "${AK_SHELL_CONFIG_DIR:-$HOME/.config/ak-shell}/settings" ]]; then
  source "${AK_SHELL_CONFIG_DIR:-$HOME/.config/ak-shell}/settings"
fi

# ── Defaults (only fill in unset values) ───────────────
source "${AK_SHELL_ROOT}/config/defaults.zsh"

# ── History ────────────────────────────────────────────
source "${AK_SHELL_ROOT}/core/history.zsh"

# ── Theme Engine ───────────────────────────────────────
source "${AK_SHELL_ROOT}/core/theme-engine.zsh"

# ── Prompt ─────────────────────────────────────────────
source "${AK_SHELL_ROOT}/core/prompt.zsh"

# ── Startup banner (only in interactive shells) ────────
if [[ $- == *i* ]] && [[ "${AK_ENABLE_BANNER:-true}" == "true" ]] \
   && [[ -f "${AK_SHELL_ROOT}/assets/banner.txt" ]]; then
  cat "${AK_SHELL_ROOT}/assets/banner.txt"
fi

# ── Ready ──────────────────────────────────────────────
export AK_SHELL_READY=1
