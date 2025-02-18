return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" }, -- Run before saving
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        javascript = { "eslint_d", "prettierd" },
        typescript = { "eslint_d", "prettierd" },
        javascriptreact = { "eslint_d", "prettierd" },
        typescriptreact = { "eslint_d", "prettierd" },
        json = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        scss = { "prettierd" },
      },
      -- Set up format-on-save
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true, -- If no formatter is available, fall back to LSP formatting
      },
      -- Customize formatters
      formatters = {
        eslint_d = {
          args = { "--fix-to-stdout", "--stdin", "--stdin-filename", "$FILENAME" },
        },
        prettierd = {
          args = { "--stdin-filepath", "$FILENAME" },
        },
      },
    },
  }
}

