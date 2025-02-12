return {
  {
    "folke/tokyonight.nvim",  -- Replace with your colorscheme plugin
    lazy = false,  -- Load immediately
    priority = 1000,  -- Ensure it loads before other UI plugins
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      }
    },
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end
  },
}

