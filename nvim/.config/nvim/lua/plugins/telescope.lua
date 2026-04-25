return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sharkdp/fd",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require("telescope").setup({
				pickers = {
					live_grep = {
						layout_config = {
							width = 0.9,
						},
						theme = "dropdown",
					},
				},
			})
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			-- This is your opts table
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {
						"lazy%-lock.json",
						"package%-lock.json",
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
					fzf = {},
				},
			})
			-- To get ui-select loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require("telescope").load_extension("ui-select")
		end,
	},
}
