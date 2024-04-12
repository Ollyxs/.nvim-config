local opt = vim.api.nvim_set_option
local cmd = vim.cmd

-- show line numbers
opt("number", true)
-- use relativenumbers
opt("relativenumber", true)
-- enable mouse usage
opt("mouse", "a")
-- enable syntax highlighting
-- cmd("syntax", "on")
-- use GUI colors
opt("termguicolors", true)
-- splits
opt("splitbelow", true)
opt("splitright", true)
-- no highlighting search results
opt("hlsearch", false)
-- use incremental search
opt("incsearch", true)
-- reduce update time
opt("updatetime", 50)
-- identation
opt("tabstop", 4)
opt("softtabstop", 4)
opt("shiftwidth", 4)
opt("expandtab", true)
opt("smartindent", true)
-- scroll
opt("scrolloff", 8)
-- signcolumn
opt("signcolumn", "yes")
opt("colorcolumn", "80")
-- leader key
-- vim.keymap.set("n", "<Space>", "<Nop>", { noremap = true })
vim.g.mapleader = ' '
-- 2-space identation for HTML
cmd("autocmd FileType html setl sw=2 sts=2 et")
-- 2-space identation for htmldjango
cmd("autocmd FileType htmldjango setl sw=2 sts=2 et")
-- 2-space identation for Lua
cmd("autocmd FileType lua setl sw=2 sts=2 et")
