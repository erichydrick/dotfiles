return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {
				"bash",
				"dockerfile",
				"graphql",
				"html",
				"http",
				"java",
				"javascript",
				"json",
				"kotlin",
				"lua",
				"python",
				"sql",
				"terraform",
				"xml",
				"yaml",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
