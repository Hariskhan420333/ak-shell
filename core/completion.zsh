# AK SHELL — Completion, Suggestions, and Syntax Highlighting

autoload -Uz compinit
compinit -u

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# ── 2. Auto-Suggestions ────────────
if [[ "${AK_ENABLE_SUGGESTIONS:-true}" == "true" ]] && [[ -f "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# ── 3. Syntax Highlighting ──────────────
if [[ "${AK_ENABLE_SYNTAX_HIGHLIGHT:-true}" == "true" ]] && [[ -f "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
  source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
