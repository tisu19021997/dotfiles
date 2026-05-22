# dotfiles

Personal terminal setup: **Ghostty + tmux + Neovim**, themed with
[Flexoki Dark](https://github.com/kepano/flexoki), tuned for mouseless
keyboard-driven work and running Claude in several panes/tabs at once.

## Install

```bash
git clone git@github.com:tisu19021997/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The installer:

1. Runs `brew bundle` (Ghostty, Neovim, ripgrep, fd, fzf, bat, eza, zoxide,
   lazygit, git-delta, gh, JetBrains Mono Nerd Font, …).
2. Symlinks `ghostty/config`, `tmux/tmux.conf`, `nvim/`, ripgrep config into
   `~/.config/`. Existing files are backed up with a timestamp.
3. Clones [tpm](https://github.com/tmux-plugins/tpm) and headlessly installs
   tmux plugins.
4. Headlessly syncs lazy.nvim plugins.
5. Appends a single source line to `~/.zshrc` (between `# >>> dotfiles
   managed >>>` markers) so changes to `zsh/zshrc.local` take effect.

Reload your shell (`exec zsh`) and launch **Ghostty**.

## Layout

```
dotfiles/
├── Brewfile
├── install.sh
├── ghostty/config       # palette + keybindings
├── tmux/tmux.conf       # flexoki status bar, vim copy mode, tpm
├── nvim/                # lazy.nvim + flexoki + telescope + LSP
│   ├── init.lua
│   └── lua/quang/{options,keymaps,lazy}.lua
└── zsh/
    ├── zshrc.local      # aliases, fzf, zoxide, vi mode
    └── ripgrep.conf
```

## Keymaps cheatsheet

### Ghostty (system level)

| Keys                  | Action                          |
| --------------------- | ------------------------------- |
| `Cmd+T`               | New tab                         |
| `Cmd+W`               | Close pane/tab                  |
| `Cmd+1..9`            | Jump to tab                     |
| `Cmd+Shift+[` / `]`   | Prev / next tab                 |
| `Cmd+Shift+Arrows`    | **Move between tmux panes** (sends tmux prefix + h/j/k/l) |
| `Cmd+Ctrl+D` / `Cmd+Ctrl+Shift+D` | Native split right / down (rarely needed — use tmux) |
| `Cmd+Shift+R`         | Reload Ghostty config           |
| `Cmd+ +/-/0`          | Font bigger / smaller / reset   |

### tmux (prefix = `Ctrl-b`)

| Keys                  | Action                          |
| --------------------- | ------------------------------- |
| `prefix \|`           | Split horizontally (keep cwd)   |
| `prefix -`            | Split vertically                |
| `prefix c`            | New window (keep cwd)           |
| `prefix h/j/k/l`      | Move between panes (also Cmd+Shift+Arrows from Ghostty) |
| `prefix H/J/K/L`      | Resize pane (repeatable)        |
| `prefix n` / `p`      | Next / prev window              |
| `prefix S`            | Toggle pane sync (broadcast — great for multi-claude) |
| `prefix [` / `]`      | Enter copy mode / paste         |
| `v` then `y` (in copy)| Vim-style select & yank to clipboard |
| `prefix r`            | Reload tmux.conf                |
| `prefix I`            | Install tpm plugins             |

The status bar shows session name, window list, **current git branch +
modified/staged/untracked counts**, cwd, and clock.

### Neovim (leader = `Space`)

Movement and editing follow standard vim. Notable adds:

| Keys                  | Action                          |
| --------------------- | ------------------------------- |
| `<leader><space>`     | Find files (Telescope)          |
| `<leader>fg`          | Live grep (ripgrep)             |
| `<leader>fb`          | Switch buffer                   |
| `<leader>/`           | Fuzzy search in current buffer  |
| `<leader>e`           | Toggle file tree                |
| `<leader>gg`          | LazyGit                         |
| `<leader>w` / `<leader>q` | Save / quit                 |
| `gd` / `gr` / `K`     | LSP definition / refs / hover   |
| `<leader>rn` / `<leader>ca` | Rename / code action      |
| `Ctrl-h/j/k/l`        | Move between vim splits **and tmux panes** (vim-tmux-navigator) |
| `Shift-h` / `Shift-l` | Prev / next buffer              |
| `jk` (insert mode)    | Escape                          |

### Running Claude in many panes

- `clh` → opens a new tmux window in the current directory and starts
  `claude`.
- `prefix S` toggles broadcast mode if you want to send the same input to
  several claude panes.
- `work [name]` → attach to (or create) a tmux session named after the
  current dir — great for "one session per project".

### Shell (vi mode)

- `Esc` to enter normal mode, `i/a` to insert. Use `v` to open the current
  command in `$EDITOR` (`nvim`).
- `Ctrl-R` fuzzy history (fzf), `Ctrl-T` fuzzy file insert, `Alt-C`
  fuzzy cd.
- `cd <fuzzy>` is `zoxide` — jumps by frecency.
- `ll` = `eza -la --git`, `cat` = `bat`, `g` = `git`, `lg` = `lazygit`.

## Updating

```bash
cd ~/dotfiles && git pull && ./install.sh
```

The installer is idempotent — re-running it only adds what's missing.

## Local-only overrides

Anything in `~/.zshrc.private` (not tracked here) is sourced last, so put
secrets, machine-specific PATHs, or work aliases there.
