#!/data/data/com.termux/files/usr/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
RESET='\033[0m'

echo -e "${RED}=== AK SHELL Uninstaller ===${RESET}"
read -p "Are you sure you want to uninstall AK SHELL? (y/N): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "Uninstall cancelled."
  exit 0
fi

echo -e "${YELLOW}Removing files...${RESET}"

# 1. Remove zshrc block
ZSHRC="$HOME/.zshrc"
if [[ -f "$ZSHRC" ]]; then
  cp "$ZSHRC" "$ZSHRC.uninstall_backup"
  sed -i '/# >>> AK SHELL >>>/,/# <<< AK SHELL <<</d' "$ZSHRC"
  echo -e "  -> Removed AK SHELL block from ~/.zshrc (Backup: ~/.zshrc.uninstall_backup)"
fi

# 2. Remove binary
rm -f "$PREFIX/bin/ak"
echo -e "  -> Removed 'ak' command."

# 3. Remove framework directory
rm -rf "$HOME/.ak-shell"
echo -e "  -> Removed ~/.ak-shell directory."

# 4. (Optional) Remove config
# rm -rf "$HOME/.config/ak-shell" # Let's keep theme settings unless user deletes

echo -e "\n${GREEN}✅ Uninstallation Complete!${RESET}"
echo -e "Restart Termux or run ${YELLOW}exec bash${RESET} to return to default shell."
