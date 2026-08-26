-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>")

-- Override LazyVim's <C-hjkl> with tmux navigation
vim.schedule(function()
    vim.keymap.set(
        "n",
        "<C-h>",
        "<cmd>TmuxNavigateLeft<cr>",
        { desc = "Navigate Left (tmux/vim)", silent = true }
    )
    vim.keymap.set(
        "n",
        "<C-j>",
        "<cmd>TmuxNavigateDown<cr>",
        { desc = "Navigate Down (tmux/vim)", silent = true }
    )
    vim.keymap.set(
        "n",
        "<C-k>",
        "<cmd>TmuxNavigateUp<cr>",
        { desc = "Navigate Up (tmux/vim)", silent = true }
    )
    vim.keymap.set(
        "n",
        "<C-l>",
        "<cmd>TmuxNavigateRight<cr>",
        { desc = "Navigate Right (tmux/vim)", silent = true }
    )
end)

-- Override Snacks explorer with oil
vim.keymap.set("n", "<leader>fe", function()
    require("oil").open()
end, { desc = "File Explorer" })
vim.keymap.set("n", "<leader>fE", function()
    require("oil").open()
end, { desc = "File Explorer (cwd)" })

vim.keymap.set("n", "<C-a>", function()
    local harpoon = require("harpoon")
    harpoon:setup()
    harpoon:list():add()
end, { desc = "Harpoon Add" })
vim.keymap.set("n", "<C-e>", function()
    local harpoon = require("harpoon")
    harpoon:setup()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon Menu" })

vim.keymap.set("n", "<leader>ff", function()
    require("telescope.builtin").find_files()
end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fn", function()
    require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
end, {})
vim.keymap.set("n", "<leader>fh", function()
    require("telescope.builtin").help_tags()
end, {})
vim.keymap.set("n", "<leader>fb", function()
    require("telescope.builtin").buffers()
end, {})
