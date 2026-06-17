# vim: filetype=zsh
# Auto-updater: checks for mshell updates every 7 days

_mshell_auto_update() {
  local mshell_dir="$HOME/.mshell"
  local timestamp_file="$mshell_dir/working/.last_update_check"
  local now=$(date +%s)
  local interval=$((7 * 24 * 60 * 60))  # 7 days in seconds

  # Read last check time
  local last_check=0
  if [[ -f "$timestamp_file" ]]; then
    last_check=$(<"$timestamp_file")
  fi

  # Check if interval has passed
  if (( (now - last_check) < interval )); then
    return 0
  fi

  # Fetch with timeout to avoid blocking shell startup
  # Try gtimeout (macOS via coreutils) first, then timeout, then fallback
  local timeout_cmd=""
  if command -v gtimeout &>/dev/null; then
    timeout_cmd="gtimeout 2"
  elif command -v timeout &>/dev/null; then
    timeout_cmd="timeout 2"
  fi

  if [[ -n "$timeout_cmd" ]]; then
    if ! $timeout_cmd git -C "$mshell_dir" fetch --quiet 2>/dev/null; then
      echo "⚠️  mshell: update check failed (network issue or timeout)" >&2
      return 0
    fi
  else
    # No timeout command available; run fetch directly but accept the risk
    if ! git -C "$mshell_dir" fetch --quiet 2>/dev/null; then
      echo "⚠️  mshell: update check failed (network issue)" >&2
      return 0
    fi
  fi

  # Check for new commits
  local behind
  behind=$(git -C "$mshell_dir" rev-list HEAD..origin/HEAD --count 2>/dev/null)

  if [[ "$behind" -gt 0 ]]; then
    echo "🔄 mshell: $behind update(s) available"
    printf "   Update now? [y/n] "
    read -r reply
    if [[ "$reply" =~ ^[Yy]$ ]]; then
      if git -C "$mshell_dir" pull --rebase --quiet 2>/dev/null; then
        echo "✅ mshell updated successfully"
        echo "$now" > "$timestamp_file"
      else
        echo "❌ mshell: update failed (possible conflicts)" >&2
        # Don't write timestamp so it retries next session
        return 0
      fi
    else
      # User declined, write timestamp so we don't ask again for 7 days
      echo "$now" > "$timestamp_file"
    fi
  else
    # No updates available, record the check
    echo "$now" > "$timestamp_file"
  fi
}

_mshell_auto_update
