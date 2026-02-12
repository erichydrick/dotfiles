return {

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"cssls",
					"docker_compose_language_service",
					"dockerls",
					"gopls",
					"jdtls",
					"jsonls",
					"lua_ls",
					"templ",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("bashls", {
				capabilities = capabilities,
			})
			vim.lsp.config("cssls", {
				capabilities = capabilities,
			})
			vim.lsp.config("docker_compose_language_service", {
				capabilities = capabilities,
			})
			vim.lsp.config("dockerls", {
				capabilities = capabilities,
			})
			vim.lsp.config("gopls", {
				capabilities = capabilities,
			})
			vim.lsp.config("jdtls", {
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
			vim.lsp.config("jsonls", {
				capabilities = capabilities,
			})
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
			})
			vim.lsp.config("templ", {
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
		end,
	},
}
