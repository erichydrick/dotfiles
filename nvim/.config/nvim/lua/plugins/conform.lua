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
				},
				format_on_save = { timeout_ms = 500, lsp_fallback = true },
			})
			-- TODO: SET UP A KEYBINDING TO MANUALLY FORMAT THE FILE (<LEADER>GF)
		end,
	},
}
