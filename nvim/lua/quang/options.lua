local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.termguicolors = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.showmode = false
opt.laststatus = 3       -- single global statusline
opt.splitbelow = true
opt.splitright = true
opt.fillchars = { eob = " " }

-- Indent
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false

-- Undo / files
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.swapfile = false
opt.backup = false
opt.updatetime = 250
opt.timeoutlen = 400

-- Clipboard with system
opt.clipboard = "unnamedplus"

-- Mouse off — you said vim all the way
opt.mouse = ""

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
