function ColorMyPencils(color)
    color = color or "kanagawa"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
end

return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                keywordStyle = { bold = true, italic = false },
                theme = "dragon",
                background = {
                    dark = "dragon",
                    light = "lotus",
                },
                transparent = false,
            })
            ColorMyPencils("kanagawa")
            -- vim.cmd("colorscheme kanagawa")
        end,
    }
}
