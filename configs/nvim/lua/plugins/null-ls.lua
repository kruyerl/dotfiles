return {
  {
    "jose-elias-alvarez/null-ls.nvim",    -- Integration for external formatters (Prettier, ESLint)
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier.with({
            filetypes = { "javascript", "typescript", "json", "html", "css" },
          }),
        },
        on_attach = function(client, bufnr)
          -- Check for the correct client capabilities (for newer Neovim versions)
          if client.server_capabilities.document_formatting then
            -- Auto format on save
            vim.cmd([[
              augroup FormatAutogroup
                autocmd!
                autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()
              augroup END
            ]])
          end
        end,
      })
    end,
  },
}

