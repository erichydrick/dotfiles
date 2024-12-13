return {
    {
        "williamboman/mason.nvim",
        dependencies = {},
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "bashls",
                    "cssls",
                    "dockerls",
                    "docker_compose_language_service",
                    "html",
                    "jdtls",
                    "lua_ls",
                    "pyright",
                    "snyk_ls",
                    "terraformls",
                    "ts_ls",
                    "yamlls",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            lspconfig.cssls.setup({
                capabilities = capabilities,
            })
            lspconfig.dockerls.setup({
                capabilities = capabilities,
            })
            lspconfig.docker_compose_language_service.setup({
                capabilities = capabilities,
            })
            lspconfig.html.setup({
                capabilities = capabilities,
            })
            lspconfig.jdtls.setup({
                cmd = {
                    "jdtls",
                    "--jvm-arg=" .. string.format(
                        "-javaagent:%s",
                        vim.fn.expand("~/.local/share/nvim/mason/share/jdtls/lombok.jar")
                    ),
                },
                settings = {
                    java = {
                        signatureHelp = { enabled = true },
                        import = { enabled = true },
                        rename = { enabled = true },
                    },
                },
                init_options = { bundles = {} },
                capabilities = capabilities,
            })
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.pyright.setup({
                capabilities = capabilities,
            })
            lspconfig.snyk_ls.setup({
                filetypes = {
                    "java",
                    "javascript",
                    "json",
                    "python",
                    "terraform",
                    "terraform-vars",
                    "typescript",
                    "yaml"
                },
                init_options = {
                    activateSnykCode = "true",
                    activateSnykIac = "true",
                    automaticAuthentication = "true",
                    enableTelementry = "false",
                    endpoint = "https://app.snyk.io",
                    token = os.getenv("SNYK_TOKEN"),
                },
                single_file_support = true,
            })
            lspconfig.terraformls.setup({
                capabilities = capabilities,
            })
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.yamlls.setup({
                capabilities = capabilities,
            })
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {}, "Go to declaration")
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {}, "Go to definition")
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {}, "Go to implementation")
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {}, "Hover text")
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {}, "Show signature")
            vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, {}, "Add workspace folder")
            vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, {}, "Remove workspace folder")
            vim.keymap.set("n", "<leader>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, {}, "List workspace folders")
            vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, {}, "Go to type definition")
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {}, "Code actions")
            vim.keymap.set("n", "<leader>f", function()
                vim.lsp.buf.format({ async = true })
            end, {}, "Format file")
        end,
    },
}
