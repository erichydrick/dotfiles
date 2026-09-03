local current_dir = vim.fn.expand("~/.local/state/omarchy/current")
local theme_file = current_dir .. "/theme/neovim.lua"

local uv = vim.uv or vim.loop

local last_sig = nil
local debounce_timer = nil
local watch_handle = nil

local function parse_theme()
	local f = io.open(theme_file, "r")
	if not f then
		return nil
	end
	local content = f:read("*a")
	f:close()

	local fn = load("return " .. (content:match("return%s+(.+)")))
	if not fn then
		return nil
	end

	local ok, specs = pcall(fn)
	if not ok or type(specs) ~= "table" then
		return nil
	end

	local colorscheme = nil
	local aether_opts = nil
	for _, spec in ipairs(specs) do
		if type(spec) == "table" then
			local pname = spec[1] or spec.name
			if type(pname) == "string" then
				if pname:match("LazyVim") then
					if type(spec.opts) == "table" and type(spec.opts.colorscheme) == "string" then
						colorscheme = spec.opts.colorscheme
					end
				elseif pname:match("aether") then
					if type(spec.opts) == "table" then
						aether_opts = spec.opts
					end
				end
			end
		end
	end

	return colorscheme, aether_opts
end

local function apply_theme()
	local colorscheme, aether_opts = parse_theme()
	if not colorscheme then
		return
	end

	-- An aether theme whose plugin is already loaded is handled by
	-- aether.nvim's own built-in hot-reload (it re-feeds opts and reloads).
	-- Let it run alone to avoid a double reload flash. Everything else —
	-- non-aether schemes and the first load of an aether theme — is applied
	-- here.
	if aether_opts and package.loaded["aether"] then
		return
	end

	local sig = colorscheme .. ":" .. (aether_opts and vim.fn.sha256(vim.inspect(aether_opts)) or "")
	if sig == last_sig then
		return
	end

	-- Load a lazy-loaded colorscheme plugin on demand before :colorscheme,
	-- so it is on the runtimepath (kanagawa, catppuccin, aether, etc.).
	pcall(function()
		require("lazy.core.loader").colorscheme(colorscheme)
	end)

	-- For an aether theme, inject the palette from the theme file before
	-- applying (the lazy spec registers the plugin but carries no colors).
	if aether_opts then
		pcall(function()
			require("aether").setup(aether_opts)
		end)
	end

	local ok, err = pcall(vim.cmd.colorscheme, colorscheme)
	if ok then
		last_sig = sig
		vim.cmd("redraw!")
	else
		last_sig = nil
		vim.notify("omarchy-theme: failed to apply " .. tostring(colorscheme) .. " (" .. tostring(err) .. ")", vim.log.levels.WARN)
	end
end

local function start_watch()
	if not uv or not uv.new_fs_event then
		return
	end

	if watch_handle then
		pcall(function()
			if not watch_handle:is_closing() then
				watch_handle:stop()
				watch_handle:close()
			end
		end)
		watch_handle = nil
	end

	if vim.fn.isdirectory(current_dir) ~= 1 then
		return
	end

	local handle = uv.new_fs_event()
	if not handle then
		return
	end

	local function on_change()
		-- The whole theme/ directory is swapped atomically; re-arm so the
		-- watcher keeps following it.
		pcall(function()
			if not handle:is_closing() then
				handle:stop()
				handle:close()
			end
		end)
		watch_handle = nil

		if debounce_timer then
			debounce_timer:stop()
		end
		debounce_timer = vim.defer_fn(function()
			debounce_timer = nil
			start_watch()
			vim.schedule(apply_theme)
		end, 1500)
	end

	local ok = handle:start(current_dir, {}, vim.schedule_wrap(on_change))
	if ok == 0 then
		watch_handle = handle
	end
end

local M = {}

function M.start()
	if watch_handle then
		pcall(function()
			if not watch_handle:is_closing() then
				watch_handle:stop()
			end
		end)
		watch_handle = nil
	end

	start_watch()

	vim.api.nvim_create_autocmd("VimLeavePre", {
		callback = function()
			if watch_handle then
				pcall(function()
					if not watch_handle:is_closing() then
						watch_handle:stop()
					end
				end)
			end
		end,
	})

	vim.api.nvim_create_user_command("OmarchyTheme", function()
		apply_theme()
	end, { desc = "Re-apply the Omarchy theme to Neovim" })
end

return M
