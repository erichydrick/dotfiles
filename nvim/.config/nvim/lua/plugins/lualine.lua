return {
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
				},
				sections = {
					lualine_a = { { "buffers" } },
					lualine_x = { { "fileformat", "filetype" } },
				},
			})

			local group = vim.api.nvim_create_augroup("LualineColorScheme", { clear = true })
			vim.api.nvim_create_autocmd("ColorScheme", {
				group = group,
				pattern = "*",
				callback = function()
					require("lualine").refresh()
				end,
			})
		end,
	},
}
