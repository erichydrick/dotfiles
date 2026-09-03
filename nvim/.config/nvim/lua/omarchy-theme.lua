local theme_file = vim.fn.expand("~/.local/state/omarchy/current/theme/neovim.lua")
local current_colorscheme = nil
local debounce_timer = nil

local function extract_colorscheme()
	local f = io.open(theme_file, "r")
	if not f then
		return nil
	end
	local content = f:read("*a")
	f:close()
	return content:match('opts%s*=%s*{%s*colorscheme%s*=%s*"([^"]+)"')
end

local function is_colorscheme_installed(name)
	if not name then
		return false
	end
	local rtp = vim.api.nvim_get_runtime_file("colors/" .. name .. ".vim", true)
	if #rtp > 0 then
		return true
	end
	local rtp_lua = vim.api.nvim_get_runtime_file("colors/" .. name .. ".lua", true)
	return #rtp_lua > 0
end

local function apply_theme()
	local cs = extract_colorscheme() or OmarchyColorscheme
	if not cs or cs == current_colorscheme then
		return
	end
	if is_colorscheme_installed(cs) then
		current_colorscheme = cs
		vim.cmd.colorscheme(cs)
	end
end

local function debounced_apply()
	if debounce_timer then
		debounce_timer:stop()
	end
	debounce_timer = vim.defer_fn(apply_theme, 100)
end

local M = {}

function M.start()
	current_colorscheme = OmarchyColorscheme
	if is_colorscheme_installed(current_colorscheme) then
		vim.cmd.colorscheme(current_colorscheme)
	else
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyDone",
			once = true,
			callback = apply_theme,
		})
	end

	local ok, poll = pcall(vim.uv.new_fs_poll)
	if ok and poll then
		poll:start(theme_file, 1000, function(err)
			if not err then
				vim.schedule(debounced_apply)
			end
		end)

		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				poll:stop()
			end,
		})
	end

	vim.api.nvim_create_user_command("OmarchyTheme", function()
		apply_theme()
	end, { desc = "Re-apply Omarchy theme colorscheme" })
end

return M
