return {
  {
    "kepano/flexoki-neovim",
    lazy = false,
    priority = 1000,
    config = function()
      require("flexoki").colorscheme({})
    end,
  },
}
