return {
  {
    "neovim/nvim-lspconfig",    -- LSP client
    config = function()
      -- Setting up ESLint with tsserver
      require('lspconfig').tsserver.setup({
        settings = {
          javascript = { format = { enable = false } },  -- Disable formatting in TSServer
          typescript = { format = { enable = false } },  -- Disable formatting in TSServer
        },
        on_attach = function(client, bufnr)
          -- Enable eslint
          if client.name == "tsserver" then
            vim.cmd('LspInstall eslint')
          end
        end,
      })
    end,
  },
}

