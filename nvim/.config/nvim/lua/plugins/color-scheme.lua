return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                keywordStyle = { bold = true, italic = false },
                theme = "dragon",
                background = {
                    dark = "dragon",
                    light = "lotus",
                },
                transparent = false,
            })
            -- vim.cmd("colorscheme kanagawa")
        end,
    },
    {
        "thesimonho/kanagawa-paper.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa-paper").setup({
                -- enable undercurls for underlined text
                undercurl = true,
                -- transparent background
                transparent = false,
                -- highlight background for the left gutter
                gutter = false,
                -- background for diagnostic virtual text
                diag_background = true,
                -- dim inactive windows. Disabled when transparent
                dim_inactive = false,
                -- set colors for terminal buffers
                terminal_colors = true,
                -- cache highlights and colors for faster startup.
                -- see Cache section for more details.
                cache = false,

                styles = {
                    -- style for comments
                    comment = { italic = true },
                    -- style for functions
                    functions = { italic = false },
                    -- style for keywords
                    keyword = { italic = false, bold = false },
                    -- style for statements
                    statement = { italic = false, bold = false },
                    -- style for types
                    type = { italic = false },
                },
                -- override default palette and theme colors
                colors = {
                    palette = {
                        sumiInk0 = "#0d0c0c",
                        sumiInk1 = "#12120f",
                        sumiInk2 = "#1D1C19",
                        sumiInk3 = "#181616",
                        sumiInk4 = "#282727",
                        sumiInk5 = "#393836",
                        sumiInk6 = "#625e5a",
                    },
                    theme = {
                        ink = {},
                        canvas = {},
                    },
                },
                -- adjust overall color balance for each theme [-1, 1]
                color_offset = {
                    ink = { brightness = 0, saturation = 0 },
                    canvas = { brightness = 0, saturation = 0 },
                },
                -- override highlight groups
                overrides = function(colors)
                    return {}
                end,

                -- uses lazy.nvim, if installed, to automatically enable needed plugins
                auto_plugins = true,
                -- enable highlights for all plugins (disabled if using lazy.nvim)
                all_plugins = package.loaded.lazy == nil,
                -- manually enable/disable individual plugins.
                -- check the `groups/plugins` directory for the exact names
                plugins = {
                    -- examples:
                    -- rainbow_delimiters = true
                    -- which_key = false
                },

                -- enable integrations with other applications
                integrations = {
                    -- automatically set wezterm theme to match the current neovim theme
                    wezterm = {
                        enabled = false,
                        -- neovim will write the theme name to this file
                        -- wezterm will read from this file to know which theme to use
                        path = (os.getenv("TEMP") or "/tmp") .. "/nvim-theme",
                    },
                },
            })
            vim.cmd.colorscheme("kanagawa-paper-ink")
        end,
    }
}
