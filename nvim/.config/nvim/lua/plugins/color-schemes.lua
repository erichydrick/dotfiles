return {
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require("kanagawa").setup({
                keywordStyle = { bold = true, italic = false },
                theme = "dragon",
                background = {
                    dark = "dragon",
                    light = "lotus",
                },
                transparent = true,
                vim.api.nvim_set_hl(0, "SnacksPicker", { bg = "NONE" }),
                styles = {
                    sidebars = "transparent",
                    float = "transparent",
                },
            })
        end,
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "kanagawa",
        },
    },
}
