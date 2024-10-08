return {
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
    vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal float<CR>')
    -- vim.keymap.set('n', '<C-N>', ':Neotree filesystem toggle reveal left')
  end
}

