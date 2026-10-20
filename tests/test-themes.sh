#!/data/data/com.termux/files/usr/bin/bash
echo "Testing Themes..."
FAIL=0
for file in themes/*.zsh; do
  if zsh -n "$file"; then
    echo "  [PASS] $file syntax OK"
  else
    echo "  [FAIL] $file has syntax errors"
    FAIL=1
  fi
done
exit $FAIL
