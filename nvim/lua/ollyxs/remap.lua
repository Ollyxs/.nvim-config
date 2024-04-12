vim.g.mapleader = ' '
-- back to ntrew
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- navigate between splits
-- down
vim.keymap.set("n", "<C-J", "<C-W><C-J>")
-- up
vim.keymap.set("n", "<C-K", "<C-W><C-K>")
-- right
vim.keymap.set("n", "<C-L", "<C-W><C-L>")
-- left
vim.keymap.set("n", "<C-H", "<C-W><C-H>")
-- change split size
vim.keymap.set("n", "<leader>>", "<C-w>10>")
vim.keymap.set("n", "<leader><", "<C-w>10<")
vim.keymap.set("n", "<leader>+", "<C-w>5+")
vim.keymap.set("n", "<leader>-", "<C-w>5-")
-- quick save
vim.keymap.set("n", "<leader>s", ":w<CR>")
-- quit
vim.keymap.set("n", "<leader>qq", ":qa<CR>")
-- terminal-normal mode
vim.keymap.set("t", "<Esc-Esc>", "<C-\\><C-n")
