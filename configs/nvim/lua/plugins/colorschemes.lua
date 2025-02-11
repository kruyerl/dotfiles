return {
  {
    "folke/tokyonight.nvim",  -- Replace with your colorscheme plugin
    lazy = false,  -- Load immediately
    priority = 1000,  -- Ensure it loads before other UI plugins
    config = function()
      local conf = require("tokyonight")
      conf.setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        }
      })

      vim.cmd("colorscheme tokyonight")  -- Set colorscheme here
    end,
  },
}

