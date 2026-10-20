# AK SHELL Troubleshooting

## 1. Themes not loading after restart
If your theme reverts to default, check if `~/.config/ak-shell/theme` exists and has the correct theme name. You can reset it by running:
`echo "AK_THEME=cyber" > ~/.config/ak-shell/theme`

## 2. Syntax highlighting not working
Make sure the plugins are installed. Run:
`ls ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh`
If missing, run `~/projects/ak-shell/install.sh` again.

## 3. Auto-suggestions not showing
Suggestions only appear for commands you have run before (stored in history). Try running `echo "test"`, then type `echo ` and press Right Arrow.

## 4. `ak: command not found`
The symlink might be broken. Run:
`ln -sf ~/.ak-shell/bin/ak $PREFIX/bin/ak`

## 5. Reverting to default shell
If you want to go back to Bash, just run `bash` or `exec bash`. To permanently remove AK SHELL, run `~/.ak-shell/uninstall.sh`.
