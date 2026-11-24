local M = {}

-- Map colorscheme names to their transparency config
local TRANSPARENCY_CONFIG = {
  ["catppuccin"] = { plugin = "catppuccin/nvim", main = "catppuccin", opts = { transparent_background = true, float = { transparent = true, solid = false } } },
  ["catppuccin-nvim"] = { plugin = "catppuccin/nvim", main = "catppuccin", opts = { transparent_background = true, float = { transparent = true, solid = false } } },
  ["catppuccin-mocha"] = { plugin = "catppuccin/nvim", main = "catppuccin", opts = { transparent_background = true, flavour = "mocha" } },
  ["catppuccin-macchiato"] = { plugin = "catppuccin/nvim", main = "catppuccin", opts = { transparent_background = true, flavour = "macchiato" } },
  ["catppuccin-frappe"] = { plugin = "catppuccin/nvim", main = "catppuccin", opts = { transparent_background = true, flavour = "frappe" } },
  ["catppuccin-latte"] = { plugin = "catppuccin/nvim", main = "catppuccin", opts = { transparent_background = true, flavour = "latte" } },
  ["tokyonight"] = { plugin = "folke/tokyonight.nvim", main = "tokyonight", opts = { transparent = true, styles = { sidebars = "transparent", floats = "transparent" } } },
  ["tokyonight-night"] = { plugin = "folke/tokyonight.nvim", main = "tokyonight", opts = { style = "night", transparent = true, styles = { sidebars = "transparent", floats = "transparent" } } },
  ["tokyonight-storm"] = { plugin = "folke/tokyonight.nvim", main = "tokyonight", opts = { style = "storm", transparent = true, styles = { sidebars = "transparent", floats = "transparent" } } },
  ["tokyonight-moon"] = { plugin = "folke/tokyonight.nvim", main = "tokyonight", opts = { style = "moon", transparent = true, styles = { sidebars = "transparent", floats = "transparent" } } },
  ["tokyonight-day"] = { plugin = "folke/tokyonight.nvim", main = "tokyonight", opts = { style = "day", transparent = true, styles = { sidebars = "transparent", floats = "transparent" } } },
  ["kanagawa"] = { plugin = "rebelot/kanagawa.nvim", main = "kanagawa", opts = { transparent = true, theme = "wave" } },
  ["kanagawa-wave"] = { plugin = "rebelot/kanagawa.nvim", main = "kanagawa", opts = { transparent = true, theme = "wave" } },
  ["kanagawa-dragon"] = { plugin = "rebelot/kanagawa.nvim", main = "kanagawa", opts = { transparent = true, theme = "dragon" } },
  ["kanagawa-lotus"] = { plugin = "rebelot/kanagawa.nvim", main = "kanagawa", opts = { transparent = true, theme = "lotus" } },
  ["gruvbox"] = { plugin = "ellisonleao/gruvbox.nvim", main = "gruvbox", opts = { transparent_mode = true } },
  ["everforest"] = { plugin = "neanias/everforest-nvim", main = "everforest", opts = { transparent_background_level = 2 } },
  ["rose-pine"] = { plugin = "rose-pine/neovim", name = "rose-pine", main = "rose-pine", opts = { disable_background = true, disable_float_background = true } },
  ["rose-pine-main"] = { plugin = "rose-pine/neovim", name = "rose-pine", main = "rose-pine", opts = { disable_background = true, disable_float_background = true, dark_variant = "main" } },
  ["rose-pine-moon"] = { plugin = "rose-pine/neovim", name = "rose-pine", main = "rose-pine", opts = { disable_background = true, disable_float_background = true, dark_variant = "moon" } },
  ["rose-pine-dawn"] = { plugin = "rose-pine/neovim", name = "rose-pine", main = "rose-pine", opts = { disable_background = true, disable_float_background = true, dark_variant = "dawn" } },
  ["nordfox"] = { plugin = "EdenEast/nightfox.nvim", main = "nightfox", setup = function() require("nightfox").setup({ options = { transparent = true } }); require("nightfox").load() end, colorscheme = "nordfox" },
  ["carbonfox"] = { plugin = "EdenEast/nightfox.nvim", main = "nightfox", setup = function() require("nightfox").setup({ options = { transparent = true } }); require("nightfox").load() end, colorscheme = "carbonfox" },
  ["duskfox"] = { plugin = "EdenEast/nightfox.nvim", main = "nightfox", setup = function() require("nightfox").setup({ options = { transparent = true } }); require("nightfox").load() end, colorscheme = "duskfox" },
  ["nightfox"] = { plugin = "EdenEast/nightfox.nvim", main = "nightfox", setup = function() require("nightfox").setup({ options = { transparent = true } }); require("nightfox").load() end, colorscheme = "nightfox" },
  ["bamboo"] = { plugin = "ribru17/bamboo.nvim", main = "bamboo", opts = { transparent = true } },
  ["bamboo-multiplex"] = { plugin = "ribru17/bamboo.nvim", main = "bamboo", opts = { transparent = true } },
  ["bamboo-vulgaris"] = { plugin = "ribru17/bamboo.nvim", main = "bamboo", opts = { transparent = true } },
  ["bamboo-light"] = { plugin = "ribru17/bamboo.nvim", main = "bamboo", opts = { transparent = true } },
  ["retro-82"] = { plugin = "OldJobobo/retro-82.nvim", main = "retro82", opts = { transparent = true } },
  ["ashen"] = { plugin = "ficcdaf/ashen.nvim", main = "ashen", opts = { transparent = true } },
  ["miasma"] = { plugin = "xero/miasma.nvim", main = "miasma", opts = { transparent = true } },
  ["lumon"] = { plugin = "Bjarne0/lumon.nvim", main = "lumon", opts = { transparent = true, styles = { sidebars = "transparent", floats = "transparent" } } },
  ["flexoki"] = { plugin = "kepano/flexoki-neovim", main = "flexoki" },
  ["flexoki-light"] = { plugin = "kepano/flexoki-neovim", main = "flexoki" },
  ["flexoki-dark"] = { plugin = "kepano/flexoki-neovim", main = "flexoki" },
  ["matteblack"] = { plugin = "tahayvr/matteblack.nvim", main = "matteblack" },
  ["aether"] = { plugin = "bjarneo/aether.nvim", main = "aether", opts = { transparent = true } },
  ["hackerman"] = { plugin = "bjarneo/hackerman.nvim" },
  ["ethereal"] = { plugin = "bjarneo/ethereal.nvim", main = "ethereal", opts = { transparent = true } },
  ["vantablack"] = { plugin = "sravioli/vantablack.nvim", main = "vantablack", opts = { transparent = true } },
  ["white"] = { plugin = "sontungexpt/white.nvim", main = "white", opts = { transparent = true } },
}

function M.get_transparency(colorscheme)
  return TRANSPARENCY_CONFIG[colorscheme]
end

function M.read_theme_file(path)
  local f = io.open(path, "r")
  if not f then
    return nil
  end
  local content = f:read("*a")
  f:close()

  -- Try to load as plain Lua (support both "return ..." and direct return)
  local fn, err = load(content, path)
  if not fn then
    -- Try prepending return
    fn, err = load("return " .. content, path)
  end
  if not fn then
    return nil, err
  end

  local ok, result = pcall(fn)
  if not ok or type(result) ~= "table" then
    return nil
  end

  return result
end

function M.parse(spec)
  -- New simple format
  if type(spec.colorscheme) == "string" then
    local colorscheme = spec.colorscheme
    local plugins = {}

    if spec.plugins then
      for _, p in ipairs(spec.plugins) do
        table.insert(plugins, p)
      end
    end

    -- Add transparency config if enabled and not explicitly disabled
    if spec.transparent ~= false then
      local trans = TRANSPARENCY_CONFIG[colorscheme]
      if trans then
        if trans.setup then
          -- Custom setup function
          table.insert(plugins, {
            trans.plugin,
            name = trans.name,
            priority = 1000,
            lazy = false,
            config = trans.setup,
          })
        elseif trans.opts or trans.main then
          table.insert(plugins, {
            trans.plugin,
            name = trans.name,
            priority = 1000,
            opts = trans.opts,
          })
        elseif trans.plugin then
          table.insert(plugins, {
            trans.plugin,
            name = trans.name,
            priority = 1000,
          })
        end
      end
    end

    return {
      colorscheme = colorscheme,
      plugins = plugins,
    }
  end

  -- Legacy LazyVim format - extract colorscheme
  local colorscheme = nil
  local plugins = {}
  local has_lazyvim = false

  for _, entry in ipairs(spec) do
    if type(entry) == "table" then
      local pname = entry[1] or entry.name
      if type(pname) == "string" then
        if pname:match("LazyVim") then
          has_lazyvim = true
          if entry.opts and entry.opts.colorscheme then
            colorscheme = entry.opts.colorscheme
          end
        else
          table.insert(plugins, entry)
        end
      else
        table.insert(plugins, entry)
      end
    end
  end

  return {
    colorscheme = colorscheme,
    plugins = plugins,
    legacy = true,
  }
end

function M.collect_all_theme_plugins()
  local seen = {}
  local plugins = {}

  local function add_from_dir(dir)
    local ok, entries = pcall(vim.fn.glob, dir .. "/*", false, true)
    if not ok then
      return
    end
    for _, d in ipairs(entries) do
      local theme_file = d .. "/neovim.lua"
      local f = io.open(theme_file, "r")
      if f then
        f:close()
        local spec = M.read_theme_file(theme_file)
        if spec then
          local parsed = M.parse(spec)
          if parsed.plugins then
            for _, p in ipairs(parsed.plugins) do
              if type(p) == "table" and type(p[1]) == "string" then
                local pname = p[1]
                if not pname:match("LazyVim") and not seen[pname] then
                  seen[pname] = true
                  -- Add as lazy for preloading
                  local copy = vim.deepcopy(p)
                  copy.lazy = copy.lazy == nil and true or copy.lazy
                  table.insert(plugins, copy)
                end
              end
            end
          elseif type(spec) == "table" and #spec > 0 then
            -- raw legacy list
            for _, p in ipairs(spec) do
              if type(p) == "table" and type(p[1]) == "string" then
                local pname = p[1]
                if not pname:match("LazyVim") and not seen[pname] then
                  seen[pname] = true
                  local copy = vim.deepcopy(p)
                  copy.lazy = copy.lazy == nil and true or copy.lazy
                  table.insert(plugins, copy)
                end
              end
            end
          end
        end
      end
    end
  end

  add_from_dir("/usr/share/omarchy/themes")
  add_from_dir(vim.fn.expand("~/.config/omarchy/themes"))

  -- Also scan installed lazy plugins for colorschemes
  local lazy_dir = vim.fn.stdpath("data") .. "/lazy"
  local ok, entries = pcall(vim.fn.glob, lazy_dir .. "/*", false, true)
  if ok then
    for _, dir in ipairs(entries) do
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

  return plugins
end

return M
