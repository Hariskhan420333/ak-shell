# AK SHELL — History configuration
# Termux-safe, dedup-aware, session-sharing history.

HISTFILE="${AK_HISTORY_FILE:-$HOME/.zsh_history}"
HISTSIZE="${AK_HISTORY_SIZE:-10000}"
SAVEHIST="${AK_HISTORY_SIZE:-10000}"

# ── Core history options ───────────────────────────────
setopt HIST_IGNORE_DUPS       # Skip consecutive duplicates
setopt HIST_IGNORE_SPACE      # Don't save commands starting with space
setopt HIST_REDUCE_BLANKS     # Trim leading/trailing/inner blanks
setopt HIST_VERIFY            # Verify before expanding history
setopt SHARE_HISTORY          # Share across concurrent sessions
setopt INC_APPEND_HISTORY     # Write to file immediately, not only on exit

# ── Duplicate policy override ──────────────────────────
if [[ "${AK_HISTORY_DUPS:-historyignore}" == "erase" ]]; then
  setopt HIST_IGNORE_ALL_DUPS
fi

# ── Mobile-friendliness: disable auto-correction ───────
unsetopt CORRECT_ALL 2>/dev/null
unsetopt CORRECT     2>/dev/null
