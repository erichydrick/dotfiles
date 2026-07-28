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
		vim.treesitter.language.register("yaml", "helm")
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "helm",
			callback = function(args)
				vim.treesitter.start(args.buf, "yaml")
			end,
		})
	end,
}
