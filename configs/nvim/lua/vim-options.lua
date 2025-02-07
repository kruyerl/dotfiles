local map = vim.keymap.set
local opt = vim.opt
local cmd = vim.cmd
local g = vim.g

opt.autoindent = true
opt.smartindent = true
opt.shiftround = true
cmd("set expandtab")
cmd("set tabstop=4")
cmd("set softtabstop=4")
cmd("set shiftwidth=4")

g.mapleader = " "
g.maplocalleader = "\\"

opt.backspace = {"eol", "start", "indent"} -- allow backspacing over everything in insert mode
opt.clipboard = "unnamedplus" -- allow neovim to access the system clipboard
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.encoding = "utf-8" -- the encoding
opt.matchpairs = {"(:)", "{:}", "[:]", "<:>"}

-- search
opt.hlsearch = true -- highlight all matches on previous search pattern
opt.ignorecase = true -- ignore case in search patterns
opt.smartcase = true -- smart case
opt.wildignore = opt.wildignore + {"*/node_modules/*", "*/.git/*", "*/vendor/*"}
opt.wildmenu = true -- make tab completion for files/buffers act like bash

-- ui
opt.cmdheight = 0 -- more space in the neovim command line for displaying messages
opt.cursorline = true -- highlight the current line
opt.laststatus = 2 -- only the last window will always have a status line
opt.lazyredraw = true -- don"t update the display while executing macros
opt.list = true

-- You can also add "space" or "eol", but I feel it"s quite annoying
opt.listchars = {
    tab = "┊ ",
    trail = "·",

    precedes = "«",
    nbsp = "×"
}
opt.mouse = "a" -- allow the mouse to be used in neovim
opt.number = true -- set numbered lines
opt.relativenumber = true
opt.signcolumn = "number"
opt.scrolloff = 18 -- minimal number of screen lines to keep above and below the cursor
opt.sidescrolloff = 3 -- minimal number of screen columns to keep to the left and right (horizontal) of the cursor if wrap is `false`
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
opt.splitbelow = true -- open new split below
opt.splitright = true -- open new split to the right
opt.wrap = false -- display a long line
opt.termguicolors = true -- enable 24-bit RGB colors

-- fold
opt.foldmethod = "marker"
opt.foldlevel = 99


-- Better pane movement
map("n", "<C-H>", "<C-w>v", { desc = "Go to Left Window", remap = true })
map("n", "<C-J>", "<C-w>s", { desc = "Go to Left Window", remap = true })

map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
