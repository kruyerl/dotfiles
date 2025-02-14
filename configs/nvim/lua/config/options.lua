-- Ensure this file is required in init.lua or config/init.lua
-- Options are automatically loaded before lazy.nvim startup
--
local map = vim.keymap.set
local opt = vim.opt
local o = vim.o
local cmd = vim.cmd
local g = vim.g

-- Indentation
opt.autoindent = true
opt.smartindent = true
opt.shiftround = true
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

-- Leader Keys
g.mapleader = " "
g.maplocalleader = "\\"

-- Backspace Behavior
opt.backspace = { "eol", "start", "indent" }

-- Clipboard
opt.clipboard = "unnamedplus" -- System clipboard access

-- Encoding
opt.fileencoding = "utf-8"
opt.encoding = "utf-8"

-- Matching Pairs
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }

-- Search Settings
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wildignore:append({ "*/node_modules/*", "*/.git/*", "*/vendor/*" })
opt.wildmenu = true

-- UI Settings
opt.cmdheight = 0 -- Hide command line when not in use (NVIM 0.9+)
opt.cursorline = false -- Highlight current line
opt.laststatus = 2 -- Always show status line
opt.lazyredraw = true -- Optimize macro execution
opt.list = true
opt.listchars = {
	tab = "┊ ",
	trail = "·",
	extends = "»",
	precedes = "«",
	nbsp = "×",
}
opt.mouse = "a" -- Enable mouse support
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes" -- Always show sign column
opt.scrolloff = 18
opt.sidescrolloff = 3
opt.splitbelow = true
opt.splitright = true
opt.wrap = false
opt.termguicolors = true -- 24-bit color support

-- Folding
opt.foldmethod = "marker"
opt.foldlevel = 99

local disabled_builtins = {
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
}
for _, plugin in pairs(disabled_builtins) do
	g["loaded_" .. plugin] = 1
end

opt.swapfile = false
opt.undofile = true -- Set to true if you want persistent undo history
opt.backup = false
opt.writebackup = false
opt.updatetime = 200 -- Faster completion (default is 4000ms)

o.timeoutlen = 300 -- Default is 1000ms (1s), 300ms is usually snappier
opt.lazyredraw = true -- Don't redraw while executing macros
opt.synmaxcol = 200 -- Stop syntax highlighting at a certain column for performance
opt.redrawtime = 1500 -- Increase max time before giving up on syntax highlight
