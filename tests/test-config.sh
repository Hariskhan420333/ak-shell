#!/data/data/com.termux/files/usr/bin/bash
echo "Testing Config Loading..."
OUTPUT=$(zsh -c 'source config/defaults.zsh; echo $AK_THEME')
if [[ "$OUTPUT" == "cyber" ]]; then
  echo "  [PASS] Defaults load correctly (Theme: $OUTPUT)"
else
  echo "  [FAIL] Defaults failed to load"
  exit 1
fi
