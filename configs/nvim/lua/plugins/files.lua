return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            local config = require("neo-tree")
            config.setup({
                event_handlers = {
                    {
                        event = "file_opened",
                        handler = function(file_path)
                            require("neo-tree.command").execute({ action = "close" })
                        end
                    },
                }
            })
            vim.keymap.set('n', '<C-e>', ':Neotree filesystem toggle float<CR>')
        end
    },
    {
        "stevearc/oil.nvim",
        keys = {
            -- {'-', function() require('oil').open() end, desc = 'Open parent directory'},
            {'<leader>fe', function() require('oil').open_float() end, desc = 'Open parent directory in a floating window'},
        },
        config = function ()
            local config = require("oil")
            config.setup({
                default_file_explorer = true,
            })
        end
    }
}
