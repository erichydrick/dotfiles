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
-- #76946A
-- vim.api.nvim_set_hl(0, "StatusColumnLineNr", { fg = "#585b70", bg = "NONE" })
vim.api.nvim_set_hl(
    0,
    "StatusColumnLineNrCursor",
    { fg = "#98BB6C", bg = "NONE", reverse = false }
)
-- Thanks to s9tpepper and his dotfiles (https://github.com/s9tpepper/dotfiles/blob/13c4c4fa9f6135a94128e08d5d4fe7657ad1d14c/neovim/.config/nvim/lua/after/after.lua#L30)

vim.o.statuscolumn = table.concat({
    "%@SignCb@", -- Clickable sign column
    "%s", -- Sign column
    "%=", -- Right align

    -- Relative line number (current line)
    "%#StatusColumnLineNrCursor#",
    "%-1{v:virtnum == 0 ? (v:relnum == 0 ? v:relnum : '') : ''}",

    -- Relative line number (non-current line)
    "%#StatusColumnLineNr#",
    "%-1{v:virtnum == 0 ? (v:relnum == 0 ? '' : v:relnum) : ''}",

    -- Padding space (current line)
    "%#StatusColumnLineNrCursor#",
    "%{v:virtnum == 0 ? (v:relnum == 0 ? ' ' : '') : ''}",

    -- Padding space (non-current line)
    "%#StatusColumnLineNr#",
    "%{v:virtnum == 0 ? (v:relnum == 0 ? '' : ' ') : ''}",

    -- Absolute line number (current line)
    "%#StatusColumnLineNrCursor#",
    "%{v:virtnum == 0 ? (v:lnum == line('.') ? v:lnum : '') : ''}",

    -- Absolute line number (non-current line)
    "%#StatusColumnLineNr#",
    "%{v:virtnum == 0 ? (v:lnum == line('.') ? '' : v:lnum) : ''}",

    "│ ", -- Separator
})

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
