-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Overwriting from the built-ins
vim.keymap.set(
    "n",
    "gi",
    vim.lsp.buf.implementation,
    {},
    "Go to implementation"
)

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>")

vim.keymap.del("n", "<leader>l")
