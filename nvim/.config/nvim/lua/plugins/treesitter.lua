return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
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
		})
	end,
}
