# dotfiles — agent guide

Personal terminal setup (Ghostty + tmux + Neovim, Flexoki Dark). `AGENTS.md` is a symlink to this file — edit only `CLAUDE.md`. User-facing overview and full keymap cheatsheet live in @README.md.

## Run
- Apply / reapply config: `./install.sh` (idempotent — safe to re-run)
- Syntax-check installer: `bash -n install.sh`
- Validate tmux config:   `tmux -f tmux/tmux.conf -L _check new-session -d 'sleep 1' && tmux -L _check kill-server`
- Reload live tmux:       `tmux source-file ~/.config/tmux/tmux.conf` (or `prefix + r`)
- Reload live Ghostty:    `Cmd+Shift+R` inside the app
- Sync nvim plugins:      `nvim --headless "+Lazy! sync" +qa`

## How edits propagate
Configs are **symlinked into `~/.config/`** by `install.sh`. Editing a file in this repo *is* editing the live config — never copy files around. Exception: `zsh/zshrc.local` is `source`d from `~/.zshrc` (not symlinked); open a fresh shell to pick up changes.

## Code style
- Conventional Commits (`feat:`, `fix:`, `docs:`, `chore:`).
- Shell scripts use `set -euo pipefail`.
- Lua: 2-space indent, matching `nvim/lua/quang/*.lua`.

## Gotchas
- **Ghostty does not allow inline `#` comments on a value line** — the comment text is parsed into the value. Put comments on their own line above. Example: `macos-option-as-alt = left  # comment` breaks.
- **`macos-option-as-alt` enum** = `false` | `left` | `right` | `both`. `true` may fail on some Ghostty versions; prefer `left`.
- **Don't change the tmux prefix from `Ctrl-b`.** Ghostty's `keybind = super+shift+left=text:\x02h` literally sends `0x02` (= `Ctrl-b`). Changing the prefix silently breaks `Cmd+Shift+Arrow` pane navigation.
- **The Flexoki palette hex values are duplicated** across `ghostty/config`, `tmux/tmux.conf` (as `%hidden` vars), and the nvim theme plugin. When tweaking colors, update all three.
- **`nvim/lazy-lock.json` is committed on purpose** — it pins plugin versions so a fresh clone reproduces. Do not `.gitignore` it.
- **Remote push uses HTTPS via `gh` credentials** (account `tisu19021997`), not SSH — SSH on this machine maps to a different GitHub identity. Don't `git remote set-url` to SSH without re-checking.

## Pointers
- User overview & keymap cheatsheet: @README.md
- Installer (idempotency lives here): @install.sh
- Brewfile (canonical tool list):    @Brewfile
