local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")

OmarchyColorscheme = nil

local function load_omarchy_theme_specs()
	local theme_file = vim.fn.expand("~/.local/state/omarchy/current/theme/neovim.lua")
	local f = io.open(theme_file, "r")
	if not f then
		return {}
	end
	local content = f:read("*a")
	f:close()

	local fn = load("return " .. content:match("return%s+(.+)"))
	if not fn then
		return {}
	end

	local ok, specs = pcall(fn)
	if not ok or type(specs) ~= "table" then
		return {}
	end

	local filtered = {}
	for _, spec in ipairs(specs) do
		if type(spec) == "table" and spec[1] == "LazyVim/LazyVim" then
			-- Extract colorscheme name from LazyVim opts
			if spec.opts and spec.opts.colorscheme then
				OmarchyColorscheme = spec.opts.colorscheme
			end
		else
			table.insert(filtered, spec)
		end
	end

	return filtered
end

local theme_specs = load_omarchy_theme_specs()
require("lazy").setup({
	spec = {
		{ import = "plugins" },
		unpack(theme_specs),
	},
})

require("omarchy-theme").start()
