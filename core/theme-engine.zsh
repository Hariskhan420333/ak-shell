# AK SHELL — Theme Engine
# Handles theme validation, loading, and persistence.

AK_THEME_DIR="${AK_SHELL_ROOT}/themes"
AK_THEME_CONFIG="${AK_SHELL_CONFIG_DIR}/theme"

# ── List available themes ──────────────────────────────
ak_theme_list() {
  # Zsh ka native glob use kar rahe hain, ls ki zaroorat nahi
  local themes=( ${AK_THEME_DIR}/*.zsh(N:t:r) )
  local current="${AK_THEME:-cyber}"
  
  echo "Available themes:"
  for t in ${themes[@]}; do
    if [[ "$t" == "$current" ]]; then
      echo "  * ${t} (active)"
    else
      echo "    ${t}"
    fi
  done
}

# ── Show current theme ─────────────────────────────────
ak_theme_current() {
  echo "Current theme: ${AK_THEME:-cyber}"
}

# ── Validate if a theme exists ─────────────────────────
ak_theme_validate() {
  local theme="$1"
  [[ -f "${AK_THEME_DIR}/${theme}.zsh" ]]
}

# ── Set theme and save to config ───────────────────────
ak_theme_set() {
  local theme="$1"
  if [[ -z "$theme" ]]; then
    echo "Usage: ak_theme_set <theme_name>" >&2
    return 1
  fi

  if ak_theme_validate "$theme"; then
    # Save to config
    mkdir -p "${AK_SHELL_CONFIG_DIR}"
    echo "AK_THEME=${theme}" > "${AK_THEME_CONFIG}"
    
    # Load it immediately
    source "${AK_THEME_DIR}/${theme}.zsh"
    export AK_THEME="$theme"
    
    echo "Theme set to: ${theme}"
    zle reset-prompt 2>/dev/null || true
  else
    echo "Error: Theme '${theme}' not found." >&2
    return 1
  fi
}

# ── Load theme on startup ──────────────────────────────
ak_theme_load() {
  # Check if saved theme exists in config
  if [[ -f "${AK_THEME_CONFIG}" ]]; then
    source "${AK_THEME_CONFIG}" # loads AK_THEME var
  fi
  
  local target="${AK_THEME:-cyber}"
  if ak_theme_validate "$target"; then
    source "${AK_THEME_DIR}/${target}.zsh"
  else
    # Fallback
    source "${AK_THEME_DIR}/cyber.zsh"
    export AK_THEME="cyber"
  fi
}

# Initialize the engine
ak_theme_load
