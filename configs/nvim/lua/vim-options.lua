vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftround = true
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.backspace = {"eol", "start", "indent"} -- allow backspacing over everything in insert mode
vim.opt.clipboard = "unnamedplus" -- allow neovim to access the system clipboard
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.encoding = "utf-8" -- the encoding
vim.opt.matchpairs = {"(:)", "{:}", "[:]", "<:>"}

-- search
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- smart case
vim.opt.wildignore = vim.opt.wildignore + {"*/node_modules/*", "*/.git/*", "*/vendor/*"}
vim.opt.wildmenu = true -- make tab completion for files/buffers act like bash

-- ui
vim.opt.cmdheight = 0 -- more space in the neovim command line for displaying messages
vim.opt.cursorline = true -- highlight the current line
vim.opt.laststatus = 2 -- only the last window will always have a status line
vim.opt.lazyredraw = true -- don"t update the display while executing macros
vim.opt.list = true
-- You can also add "space" or "eol", but I feel it"s quite annoying
vim.opt.listchars = {
    tab = "┊ ",
    trail = "·",
    extends = "»",
    precedes = "«",
    nbsp = "×"
}
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.number = true -- set numbered lines
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"
vim.opt.scrolloff = 18 -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 3 -- minimal number of screen columns to keep to the left and right (horizontal) of the cursor if wrap is `false`
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.splitbelow = true -- open new split below
vim.opt.splitright = true -- open new split to the right
vim.opt.wrap = false -- display a long line
vim.opt.termguicolors = true -- enable 24-bit RGB colors
-- fold
vim.opt.foldmethod = "marker"
vim.opt.foldlevel = 99
