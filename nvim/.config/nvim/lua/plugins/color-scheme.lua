function ColorMyPencils(color)
	color = color or "kanagawa"

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

	vim.cmd.colorscheme(color)
end

return {
	{
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
				transparent = true,
			})
			ColorMyPencils()
			-- vim.cmd("colorscheme kanagawa")
		end,
	},
}
