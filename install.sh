#!/data/data/com.termux/files/usr/bin/bash
set -e

AK_SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AK_DEST_DIR="$HOME/.ak-shell"
AK_CONFIG_DIR="$HOME/.config/ak-shell"
ZSHRC="$HOME/.zshrc"

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
RESET='\033[0m'

echo -e "${CYAN}=== AK SHELL Installer ===${RESET}"

# 1. Dependencies Check
echo -e "${YELLOW}[1/4] Checking dependencies...${RESET}"
for pkg in zsh git; do
  if ! command -v $pkg >/dev/null 2>&1; then
    echo -e "${RED}Error: $pkg is not installed.${RESET}"
    echo "Please run: pkg install $pkg"
    exit 1
  fi
done

# 2. Install Plugins
echo -e "${YELLOW}[2/4] Installing plugins...${RESET}"
mkdir -p "$HOME/.zsh"
if [[ ! -d "$HOME/.zsh/zsh-autosuggestions" ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.zsh/zsh-autosuggestions" >/dev/null 2>&1
  echo -e "  -> zsh-autosuggestions installed."
fi
if [[ ! -d "$HOME/.zsh/zsh-syntax-highlighting" ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh/zsh-syntax-highlighting" >/dev/null 2>&1
  echo -e "  -> zsh-syntax-highlighting installed."
fi

# 3. Copy Framework Files
echo -e "${YELLOW}[3/4] Installing AK SHELL framework...${RESET}"
rm -rf "$AK_DEST_DIR"
mkdir -p "$AK_DEST_DIR" "$AK_CONFIG_DIR"
cp -r "$AK_SRC_DIR"/* "$AK_DEST_DIR"/

# Make CLI executable and link it
chmod +x "$AK_DEST_DIR/bin/ak"
ln -sf "$AK_DEST_DIR/bin/ak" "$PREFIX/bin/ak"
echo -e "  -> Framework installed to ~/.ak-shell"
echo -e "  -> 'ak' command registered globally."

# 4. Setup Zsh Config
echo -e "${YELLOW}[4/4] Configuring ~/.zshrc...${RESET}"
if ! grep -q "# >>> AK SHELL >>>" "$ZSHRC" 2>/dev/null; then
  # Backup existing zshrc
  [[ -f "$ZSHRC" ]] && cp "$ZSHRC" "$ZSHRC.backup.$(date +%Y%m%d%H%M%S)"
  
  cat >> "$ZSHRC" <<'ZSH_CONFIG'

# >>> AK SHELL >>>
export AK_SHELL_ROOT="$HOME/.ak-shell"
[[ -f "$AK_SHELL_ROOT/core/init.zsh" ]] && source "$AK_SHELL_ROOT/core/init.zsh"
# <<< AK SHELL <<<
ZSH_CONFIG
  echo -e "  -> ~/.zshrc updated. (Backup created)"
else
  echo -e "  -> AK SHELL already configured in ~/.zshrc."
fi

echo -e "\n${GREEN}✅ Installation Complete!${RESET}"
echo -e "Restart Termux or run ${CYAN}zsh${RESET} to see the magic."
