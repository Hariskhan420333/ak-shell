#!/data/data/com.termux/files/usr/bin/bash
echo "Testing Installer Syntax..."
if bash -n install.sh; then
  echo "  [PASS] install.sh syntax OK"
else
  echo "  [FAIL] install.sh has syntax errors"
  exit 1
fi
if bash -n uninstall.sh; then
  echo "  [PASS] uninstall.sh syntax OK"
else
  echo "  [FAIL] uninstall.sh has syntax errors"
  exit 1
fi
