return {
    "numToStr/FTerm.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
        require("FTerm")
        vim.keymap.set("n", "<A-t>", '<CMD>lua require("FTerm").toggle()<CR>')
        vim.keymap.set(
            "t",
            "<A-t>",
            '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>'
        )
    end,
}
