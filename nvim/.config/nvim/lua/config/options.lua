-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Overrides from defaults
vim.g.ai_cmp = false
vim.g.snacks_animate = false
vim.g.lazyvim_picker = "telescope"

local opt = vim.opt

-- Overrides from defaults
opt.clipboard = ""
opt.cursorline = false
opt.list = false
opt.scrolloff = 10
opt.shiftwidth = 4
opt.smartcase = true
opt.splitbelow = true
opt.splitright = true
opt.statuscolumn = "%{v:relnum} %{v:lnum}"
opt.tabstop = 4

-- My options
opt.autoread = true
opt.backspace = { "start", "eol", "indent" }
opt.encoding = "utf-8"
opt.expandtab = true
opt.fileencoding = "utf-8"
opt.softtabstop = 4
opt.swapfile = false
vim.diagnostic.config({
    virtual_text = true,
    severity_sort = { reverse = true },
})
