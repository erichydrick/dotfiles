vim.g.mapleader = " "

vim.cmd("set autoread")
vim.cmd("set expandtab")
vim.cmd("set number")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set tabstop=4")

vim.diagnostic.config({
    virtual_lines = true,
    severity_sort = { reverse = true },
})

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>")

vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.ignorecase = true
vim.opt.scrolloff = 10
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false

-- Line and relative numbers, styled to match the current theme.
vim.o.number = true
vim.o.relativenumber = true

vim.o.statuscolumn = table.concat {
    '%@SignCb@',
    '%s',
    '%=',
    '%#CursorLineNr#',
    "%{v:virtnum == 0 ? (v:relnum == 0 ? ' ' : '') : ''}",
    '%#LineNr#',
    "%{v:virtnum == 0 ? (v:relnum == 0 ? '' : ' ') : ''}",
    '%#CursorLineNr#',
    "%2{v:virtnum == 0 ? (v:relnum == 0 ? v:relnum : '') : ''}",
    '%#LineNr#',
    "%2{v:virtnum == 0 ? (v:relnum == 0 ? '' : v:relnum) : ''}",
    ' ',
    '%#CursorLineNr#',
    "%{v:virtnum == 0 ? (v:lnum == line('.') ? v:lnum : '') : ''}",
    '%#LineNr#',
    "%{v:virtnum == 0 ? (v:lnum == line('.') ? '' : v:lnum) : ''}",
    '│ ',
}
