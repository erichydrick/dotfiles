return {
    {
        "stevearc/conform.nvim",
        opts = {},
        config = function()
            local conform = require("conform")
            conform.setup({
                formatters_by_ft = {
                    java = {
                        "spotless_gradle",
                        "google-java-format",
                        stop_after_first = true,
                    },
                    javascript = {
                        "prettierd",
                        "prettier",
                        stop_after_first = true,
                    },
                    lua = { "stylua" },
                    yaml = { "yamlfix" },
                },
                format_on_save = nil,
                vim.keymap.set(
                    "n",
                    "<leader>cf",
                    "conform.format({ async = true })"
                ),
            })
        end,
    },
}
