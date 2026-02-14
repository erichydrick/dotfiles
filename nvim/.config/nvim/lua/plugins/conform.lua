return {
    {
        "stevearc/conform.nvim",
        opts = {
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
            format_on_save = { timeout_ms = 500, lsp_fallback = true },
            vim.keymap.set(
                "n",
                "<leader>cf",
                "conform.format({ async = true })"
            ),
        },
    },
}
