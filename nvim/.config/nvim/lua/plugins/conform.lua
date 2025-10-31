return {
    {
        "stevearc/conform.nvim",
        opts = {},
        config = function()
            local conform = require("conform")
            conform.setup({
                formatters_by_ft = {
                    javascript = { "prettierd", "prettier", stop_after_first = true },
                    lua = { "stylua" },
                    yaml = { "yamlfix" }
                },
                format_on_save = { timeout_ms = 500, lsp_fallback = true },
                vim.keymap.set("n", "<leader>cf", "conform.format({ async = true })")
            })
        end,
    },
}
