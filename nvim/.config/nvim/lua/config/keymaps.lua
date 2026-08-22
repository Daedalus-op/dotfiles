-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

map("n", "<M-s>", "<Cmd>SudaWrite<CR>", { desc = "Suda Write" })
map("n", "<M-o>", "<Cmd>Lf<CR>", { desc = "Open LF File manager" })
