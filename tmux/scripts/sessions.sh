#!/usr/bin/env bash
# Plain-text list of all tmux sessions, for the status-left.
# Active session wrapped in ▎ bars so it pops without needing color codes
# inside #() output (which not all tmux versions re-interpret reliably).

set -euo pipefail

current="$(tmux display-message -p '#S' 2>/dev/null || echo '')"

out=""
while read -r name; do
  if [[ "$name" == "$current" ]]; then
    out="${out}▎ ${name} ▎"
  else
    out="${out}  ${name}  "
  fi
done < <(tmux list-sessions -F '#S' 2>/dev/null)

printf '%s' "$out"
