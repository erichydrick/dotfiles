local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")

local omarchy_spec = require("omarchy-theme-spec")

local theme_file = vim.fn.expand("~/.local/state/omarchy/current/theme/neovim.lua")
local spec = omarchy_spec.read_theme_file(theme_file)
local parsed = nil
if spec then
	parsed = omarchy_spec.parse(spec)
	if parsed.colorscheme then
		OmarchyColorscheme = parsed.colorscheme
	end
end

local theme_plugins = {}
if parsed and parsed.plugins then
	for _, p in ipairs(parsed.plugins) do
		table.insert(theme_plugins, p)
	end
end

local all_theme_plugins = omarchy_spec.collect_all_theme_plugins()

require("lazy").setup({
	spec = {
		{ import = "plugins" },
		unpack(theme_plugins),
		unpack(all_theme_plugins),
	},
})

if OmarchyColorscheme then
	pcall(vim.cmd.colorscheme, OmarchyColorscheme)
end

require("omarchy-theme").start()
