return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require("lualine").setup({
            options = {
                theme = "kanagawa-paper-ink",
            },
            sections = {
                lualine_a = { { "buffers" } },
                lualine_x = { { "fileformat", "filetype" } },
            },
        })
    end,
}
