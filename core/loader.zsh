# AK SHELL — Cinematic Loaders

ak_run_loader() {
  local style="${AK_LOADER_STYLE:-none}"
  [[ "$style" == "none" ]] && return 0

  clear

  case "$style" in
    progress)
      echo -e "\033[1;36mInitializing AK SHELL...\033[0m"
      # Ab total 2.5 seconds lega (10 steps * 0.25s)
      for i in {1..10}; do
        printf "\r\033[1;32m[%-10s] %d%%\033[0m" "$(printf '■%.0s' {1..$i})" $((i*10))
        sleep 0.25
      done
      echo -e "\n\033[1;32mDone.\033[0m"
      ;;

    spinner)
      local chars=('|' '/' '-' '\')
      echo -e "\033[1;36mBooting System...\033[0m"
      # 8 rotations * 4 chars * 0.08s = ~2.5 seconds
      for i in {1..8}; do
        for c in "${chars[@]}"; do
          printf "\r\033[1;33mLoading %s\033[0m" "$c"
          sleep 0.08
        done
      done
      echo -e "\r\033[1;32mLoading ✓\033[0m"
      ;;

    boot)
      # Zyada lines aur lamba sleep (Total ~3 seconds)
      echo -e "\033[1;36m[ BOOT SEQUENCE INITIATED ]\033[0m"
      sleep 0.5
      echo -e "\033[1;33m[ OK ]\033[0m Connecting to local environment..."
      sleep 0.6
      echo -e "\033[1;33m[ OK ]\033[0m Loading core modules and themes..."
      sleep 0.5
      echo -e "\033[1;33m[ OK ]\033[0m Applying custom configurations..."
      sleep 0.6
      echo -e "\033[1;32m[ SUCCESS ]\033[0m System Ready."
      sleep 0.5
      ;;

    matrix)
      echo -e "\033[1;32mInjecting matrix...\033[0m"
      # 15 steps * 0.15s = 2.25 seconds
      for i in {1..15}; do
        printf "\r\033[1;32m> %s %s %s %s %s\033[0m" "$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 4 | head -n 1)" "$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 4 | head -n 1)" "$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 4 | head -n 1)" "$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 4 | head -n 1)" "$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 4 | head -n 1)"
        sleep 0.15
      done
      echo -e "\r\033[1;36mAccess Granted.        \033[0m"
      sleep 0.5
      ;;
  esac
  sleep 0.2
  clear
}

[[ -f "$HOME/.config/ak-shell/loader" ]] && source "$HOME/.config/ak-shell/loader"
ak_run_loader
