return { 
  "catppuccin/nvim", 
  lazy = false,
  name = "catppuccin", 
  priority = 1000, 
  config = function()
    local config = require("catppuccin")
    config.setup({
      flavour = "auto",
      transparent_background = true,
      show_end_of_buffer = false,
    })
    
    vim.cmd.colorscheme "catppuccin"
  end
  
  }
