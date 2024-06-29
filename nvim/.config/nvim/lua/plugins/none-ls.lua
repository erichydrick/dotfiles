return {
	"nvimtools/none-ls.nvim",
	enabled = false,
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				require("none-ls.formatting.ruff"),
				require("none-ls.diagnostics.eslint"),
				require("none-ls.formatting.prettier"),
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
