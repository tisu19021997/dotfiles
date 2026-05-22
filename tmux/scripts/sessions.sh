#!/usr/bin/env bash
# Print all tmux sessions inline for the status bar.
# The attached session is highlighted; others are dim.
# Called from status-left in tmux.conf.
#
# IMPORTANT: any literal '#' in the output (e.g. the '#' of a hex color)
# must be doubled as '##' — otherwise tmux interprets it as the start of
# a new #[...] format directive and we end up rendering raw text.

set -euo pipefail

# Flexoki palette (no '#' prefix — we add '##' in the printf below)
BG="100F0F"
BG2="1C1B1A"
TX2="878580"
BLUE="4385BE"

current="$(tmux display-message -p '#S' 2>/dev/null || echo '')"

tmux list-sessions -F '#S' 2>/dev/null | while read -r name; do
  if [[ "$name" == "$current" ]]; then
    printf "#[bg=##%s,fg=##%s,bold] %s #[bg=##%s,fg=##%s]" "$BLUE" "$BG" "$name" "$BG2" "$BLUE"
  else
    printf "#[bg=##%s,fg=##%s] %s " "$BG2" "$TX2" "$name"
  fi
done
