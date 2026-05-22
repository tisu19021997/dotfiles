#!/usr/bin/env bash
# Print all tmux sessions inline for the status bar.
# The attached session is highlighted; others are dim.
# Called from status-left in tmux.conf.

set -euo pipefail

# Flexoki palette
BG="#100F0F"
BG2="#1C1B1A"
TX3="#575653"
TX2="#878580"
BLUE="#4385BE"

current="$(tmux display-message -p '#S' 2>/dev/null || echo '')"

tmux list-sessions -F '#S' 2>/dev/null | while read -r name; do
  if [[ "$name" == "$current" ]]; then
    printf "#[bg=%s,fg=%s,bold] %s #[bg=%s,fg=%s]" "$BLUE" "$BG" "$name" "$BG2" "$BLUE"
  else
    printf "#[bg=%s,fg=%s] %s " "$BG2" "$TX2" "$name"
  fi
done
