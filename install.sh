#!/usr/bin/env bash
# Idempotent installer for this dotfiles repo.
# - installs Homebrew packages from ./Brewfile
# - symlinks configs into ~/.config and home
# - bootstraps tmux plugin manager
# - sources zsh/zshrc.local from ~/.zshrc

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cyan()  { printf '\033[36m%s\033[0m\n' "$*"; }
green() { printf '\033[32m%s\033[0m\n' "$*"; }
warn()  { printf '\033[33m%s\033[0m\n' "$*"; }

# ─── 1. Homebrew ─────────────────────────────────────────────────────────────
if ! command -v brew >/dev/null; then
  cyan "==> Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

cyan "==> brew bundle"
brew bundle --file="$DOTFILES/Brewfile"

# fzf shell integration (idempotent)
if [[ -x /opt/homebrew/opt/fzf/install ]]; then
  /opt/homebrew/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish >/dev/null
fi

# ─── 2. Symlinks ─────────────────────────────────────────────────────────────
link() {
  local src=$1 dst=$2
  mkdir -p "$(dirname "$dst")"
  if [[ -e $dst && ! -L $dst ]]; then
    local backup="${dst}.backup.$(date +%Y%m%d%H%M%S)"
    warn "  backup existing $dst -> $backup"
    mv "$dst" "$backup"
  fi
  ln -sfn "$src" "$dst"
  green "  linked $dst -> $src"
}

cyan "==> Linking configs"
link "$DOTFILES/ghostty/config"   "$HOME/.config/ghostty/config"
link "$DOTFILES/tmux/tmux.conf"   "$HOME/.config/tmux/tmux.conf"
link "$DOTFILES/tmux/tmux.conf"   "$HOME/.tmux.conf"     # fallback for older tmux
link "$DOTFILES/nvim"             "$HOME/.config/nvim"
link "$DOTFILES/zsh/ripgrep.conf" "$HOME/.config/ripgrep/config"

# ─── 3. tpm (tmux plugin manager) ────────────────────────────────────────────
TPM="$HOME/.config/tmux/plugins/tpm"
if [[ ! -d $TPM ]]; then
  cyan "==> Cloning tpm"
  git clone --depth=1 https://github.com/tmux-plugins/tpm "$TPM"
fi

# ─── 4. Wire zshrc.local into ~/.zshrc ───────────────────────────────────────
ZSHRC="$HOME/.zshrc"
MARK="# >>> dotfiles managed >>>"
END="# <<< dotfiles managed <<<"
if ! grep -q "$MARK" "$ZSHRC" 2>/dev/null; then
  cyan "==> Appending source block to $ZSHRC"
  {
    echo ""
    echo "$MARK"
    echo "[[ -f \"$DOTFILES/zsh/zshrc.local\" ]] && source \"$DOTFILES/zsh/zshrc.local\""
    echo "$END"
  } >> "$ZSHRC"
else
  green "  zshrc already wired"
fi

# ─── 5. Install tpm plugins headlessly if tmux is running, else skip ─────────
if [[ -x $TPM/bin/install_plugins ]]; then
  cyan "==> Installing tmux plugins"
  "$TPM/bin/install_plugins" || warn "tpm install_plugins failed; run prefix+I inside tmux"
fi

# ─── 6. Neovim: trigger lazy.nvim sync ───────────────────────────────────────
if command -v nvim >/dev/null; then
  cyan "==> Bootstrapping nvim plugins (headless)"
  nvim --headless "+Lazy! sync" +qa || warn "nvim sync had warnings — open nvim and run :Lazy"
fi

green ""
green "✓ Done. Open Ghostty and run: source ~/.zshrc"
green "  Then start tmux with: tmux"
green "  If tmux status looks unstyled, hit prefix(Ctrl-b) + I to install plugins."
