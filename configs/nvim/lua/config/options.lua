-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
local map = vim.keymap.set
local opt = vim.opt
local cmd = vim.cmd
-- local g = vim.g

-- cmdheight
opt.cmdheight = 0

-- tabstop
cmd("set tabstop=4")
cmd("set softtabstop=4")
cmd("set shiftwidth=4")

-- scrolloff
opt.scrolloff = 18
opt.sidescrolloff = 3

-- search
opt.wildignore = opt.wildignore + { "*/node_modules/*", "*/.git/*", "*/vendor/*" }
