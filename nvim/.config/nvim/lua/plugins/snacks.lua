return {
    "snacks.nvim",
    opts = {
        bigfile = { enabled = true },
        explorer = { enabled = false },
        indent = { enabled = false },
        input = { enabled = false },
        notifier = { enabled = false },
        picker = { enabled = false },
        quickfile = { enabled = true },
        scope = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = false }, -- we set this in options.lua
        terminal = { enabled = false },
        words = { enabled = false },
    },
    keys = {
        { "<leader>fe", false },
        { "<leader>fE", false },
        { "<leader>e", false },
        { "<leader>E", false },
    },
}
