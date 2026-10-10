return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("noice").setup({
            cmdline = {
                enabled = true,
                view = "cmdline_popup",
            },
            health = { checker = false },
            lsp = {
                progress = { enabled = false },
                hover = { enabled = false },
                signature = { enabled = false },
                message = { enabled = false },
            },
            messages = { enabled = false },
            notify = { enabled = false },
            popupmenu = { enabled = false },
            views = {
                cmdline_popup = { position = { row = "25%", col = "50%" } },
            },
            -- presets = { command_palette = true },
        })
    end,
}
