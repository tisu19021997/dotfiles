local map = vim.keymap.set

-- Save / quit
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Force quit all" })

-- Better escape
map("i", "jk", "<esc>", { desc = "Escape" })
map("i", "kj", "<esc>", { desc = "Escape" })

-- Window navigation (matches tmux: Ctrl+hjkl seamless via vim-tmux-navigator)
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Keep cursor centered when half-paging / searching
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Move lines (visual)
map("v", "J", ":m '>+1<cr>gv=gv")
map("v", "K", ":m '<-2<cr>gv=gv")

-- Don't yank on paste-over
map("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })

-- Yank to system explicitly (already default w/ unnamedplus)
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system" })
map("n", "<leader>Y", [["+Y]], { desc = "Yank line to system" })

-- Clear search highlight
map("n", "<esc>", "<cmd>nohlsearch<cr>")
