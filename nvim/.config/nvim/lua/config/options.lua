-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Overrides from defaults
vim.g.snacks_animate = false
vim.g.lazyvim_picker = "telescope"

local opt = vim.opt

-- Overrides from defaults
opt.clipboard = ""
opt.cursorline = true
opt.scrolloff = 10
opt.shiftwidth = 4
opt.smartcase = true
opt.splitbelow = true
opt.splitright = true
opt.statuscolumn = "%{v:relnum} %{v:lnum}"

-- My options
opt.backspace = { "start", "eol", "indent" }
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.swapfile = false

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = { reverse = true },
})
