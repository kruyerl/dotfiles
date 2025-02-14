return {
  {
    "rose-pine/neovim",
    lazy = false,
    opt = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        float = "transparent",
      },
    },
    config = function()
      require("rose-pine").setup({
        variant = "auto",
        disable_background = false,
      })
      vim.cmd([[colorscheme rose-pine-dawn]])

    end
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        transparent_mode = true,
      })
      -- vim.o.background = "dark" -- or "light" for light mode
      -- vim.cmd([[colorscheme gruvbox]])
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    -- priority = 1000,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      }
    },
    config = function()
      -- vim.cmd([[colorscheme tokyonight]])
    end
  },
}

