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

-- Register every color-scheme plugin so a theme switch can be applied live.
-- lazy only loads plugins it knows about from the startup spec, so a scheme
-- that wasn't current at boot would otherwise be absent from the runtimepath.
--
-- Sources, deduped by repo:
--  1. The Omarchy theme dirs (curated, correct names): every theme's neovim.lua.
--  2. A fallback scan of installed lazy plugins that ship a colors/ directory
--     (catches schemes -- like aether -- whose theme dir is empty on disk).
--
-- All are marked lazy so they aren't autoloaded until switched to.
local function collect_repos_from_themes(seen, plugins)
	local dirs = vim.fn.glob("/usr/share/omarchy/themes/*", false, true)
	for _, d in ipairs(vim.fn.glob(vim.fn.expand("~/.config/omarchy/themes/*"), false, true)) do
		table.insert(dirs, d)
	end
	for _, dir in ipairs(dirs) do
		local f = io.open(dir .. "/neovim.lua", "r")
		if f then
			local content = f:read("*a")
			f:close()
			local fn = load("return " .. (content:match("return%s+(.+)")))
			if fn then
				local ok, specs = pcall(fn)
				if ok and type(specs) == "table" then
					for _, spec in ipairs(specs) do
						if type(spec) == "table" and type(spec[1]) == "string"
							and not spec[1]:match("LazyVim") and not seen[spec[1]] then
							seen[spec[1]] = true
							table.insert(plugins, { spec[1], lazy = true })
						end
					end
				end
			end
		end
	end
end

local function collect_repos_from_install(seen, plugins)
	local lazy_dir = vim.fn.stdpath("data") .. "/lazy"
	for _, dir in ipairs(vim.fn.glob(lazy_dir .. "/*", false, true)) do
		if vim.fn.isdirectory(dir .. "/colors") == 1 then
			local f = io.open(dir .. "/.git/config", "r")
			if f then
				local cfg = f:read("*a")
				f:close()
				local repo = cfg:match('url%s*=%s*https://github%.com/([^%s]+)')
				if repo then
					repo = repo:gsub("%.git$", "")
					if not seen[repo] then
						seen[repo] = true
						table.insert(plugins, { repo, lazy = true })
					end
				end
			end
		end
	end
end

local function load_all_theme_plugins(current_specs)
	local seen = {}
	for _, entry in ipairs(current_specs) do
		if type(entry) == "table" and type(entry[1]) == "string" then
			seen[entry[1]] = true
		end
	end

	local plugins = {}
	collect_repos_from_themes(seen, plugins)
	collect_repos_from_install(seen, plugins)
	return plugins
end

local theme_specs = load_omarchy_theme_specs()
local all_theme_plugins = load_all_theme_plugins(theme_specs)
require("lazy").setup({
	spec = {
		{ import = "plugins" },
		unpack(theme_specs),
		unpack(all_theme_plugins),
	},
})

if OmarchyColorscheme then
	vim.cmd.colorscheme(OmarchyColorscheme)
end

require("omarchy-theme").start()
