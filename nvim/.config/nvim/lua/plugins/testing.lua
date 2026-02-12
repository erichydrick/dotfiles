function FTermTest(cmd)
    print(cmd)
    require("FTerm").run(cmd)
end

return {
    "vim-test/vim-test",
    config = function()
        vim.keymap.set("n", "<leader>t", ":TestNearest<CR>")
        vim.keymap.set("n", "<leader>T", ":TestFile<CR>")
        vim.keymap.set("n", "<leader>a", ":TestSuite<CR>")
        vim.keymap.set("n", "<leader>l", ":TestLast<CR>")
        vim.keymap.set("n", "<leader>v", ":TestVisit<CR>")

        vim.g["test#custom_strategies"] = {
            fterm = FTermTest,
        }
        vim.cmd("let test#strategy = 'fterm'")
    end,
}
