return {
    "snacks.nvim",
    opts = {
        explorer = { enabled = false },
        indent = { enabled = false },
        input = { enabled = false },
        notifier = { enabled = false },
        scope = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = false }, -- we set this in options.lua
        toggle = { map = LazyVim.safe_keymap_set },
        words = { enabled = false },
        bigfile = { enabled = true },
        quickfile = { enabled = true },
        terminal = { enabled = false },
    },
}
