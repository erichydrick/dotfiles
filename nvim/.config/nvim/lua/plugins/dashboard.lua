return {
    {
        {
            'nvimdev/dashboard-nvim',
            event = 'VimEnter',
            enabled = false,
            config = function()
                require('dashboard').setup {
                    theme = 'hyper',
                    config = {
                        week_header = {
                            enable = true,
                        },
                        shortcut = {
                            { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
                            {
                                icon = ' ',
                                icon_hl = '@variable',
                                desc = 'Files',
                                group = 'Label',
                                action = 'Telescope find_files',
                                key = 'f',
                            },
                            {
                                desc = ' Apps',
                                group = 'DiagnosticHint',
                                action = 'Telescope app',
                                key = 'a',
                            },
                            {
                                desc = ' dotfiles',
                                group = 'Number',
                                action = 'Telescope dotfiles',
                                key = 'd',
                            },
                        },
                        packages = { enable = true },
                        project = { enable = true, limit = 8, icon = '', label = '  Recent projects', action = 'Telescope find_files cwd=' },
                        mru = { enable = true, limit = 10, icon = '', label = '  Recent files', cwd_only = false },
                        footer = {},
                        vertical_center = true,
                    },
                    -- config
                }
            end,
            dependencies = { { 'nvim-tree/nvim-web-devicons' } }
        }
    },
    {
        'goolord/alpha-nvim',
        config = function()
            require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
        end
    },
}
