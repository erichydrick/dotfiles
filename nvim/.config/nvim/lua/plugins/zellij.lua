return {
	"https://git.sr.ht/~swaits/zellij-nav.nvim",
	lazy = true,
	event = "VeryLazy",
	config = function()
		vim.keymap.set("n", "<leader><A-h>", "<cmd>ZellijNavigateLeft<CR>", { silent = true, desc = "Navigate Left" })
		vim.keymap.set("n", "<leader><A-j>", "<cmd>ZellijNavigateDown<CR>", { silent = true, desc = "Navigate Down" })
		vim.keymap.set("n", "<leader><A-k>", "<cmd>ZellijNavigateUp<CR>", { silent = true, desc = "Navigate Up" })
		vim.keymap.set("n", "<leader><A-l>", "<cmd>ZellijNavigateRight<CR>", { silent = true, desc = "Navigate Right" })
	end,
}
