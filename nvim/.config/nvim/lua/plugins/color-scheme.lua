return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			keywordStyle = { bold = true, italic = false },
			theme = "dragon",
			background = {
				dark = "dragon",
				light = "lotus",
			},
			transparent = false,
		})
		vim.cmd("colorscheme kanagawa")
	end,
}
