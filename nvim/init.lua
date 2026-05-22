-- ─── init.lua ────────────────────────────────────────────────────────────────
-- Lean, vim-all-the-way Neovim config.
-- Bootstraps lazy.nvim, loads options/keymaps/plugins.

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("quang.options")
require("quang.keymaps")
require("quang.lazy")
