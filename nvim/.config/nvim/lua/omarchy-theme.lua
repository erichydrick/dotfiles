local current_dir = vim.fn.expand("~/.local/state/omarchy/current")
local theme_file = current_dir .. "/theme/neovim.lua"
local uv = vim.uv or vim.loop

local omarchy_spec = require("omarchy-theme-spec")

local last_sig = nil
local debounce_timer = nil
local watch_handle = nil

local function apply_theme()
	local spec = omarchy_spec.read_theme_file(theme_file)
	if not spec then
		return
	end

	local parsed = omarchy_spec.parse(spec)
	if not parsed or not parsed.colorscheme then
		return
	end

	local colorscheme = parsed.colorscheme

	-- Enable transparency if supported
	local trans = omarchy_spec.get_transparency(colorscheme)
	if trans and trans.setup then
		pcall(trans.setup)
	elseif trans and trans.opts then
		local ok, mod = pcall(require, trans.main or trans.plugin:gsub(".*/", ""))
		if ok then
			if type(mod.setup) == "function" then
				pcall(mod.setup, trans.opts)
			elseif trans.main then
				-- Try to load main module and setup
				local main_mod = trans.main
				local ok2, m2 = pcall(require, main_mod)
				if ok2 and type(m2.setup) == "function" then
					pcall(m2.setup, trans.opts)
				end
			end
		end
	elseif trans and trans.opts then
		-- For plugins that use opts in lazy style
	end

	local sig = colorscheme
	if sig == last_sig then
		return
	end

	pcall(function()
		require("lazy.core.loader").colorscheme(colorscheme)
	end)

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
