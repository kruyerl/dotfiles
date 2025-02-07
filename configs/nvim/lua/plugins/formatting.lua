return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        prettierd = {
          command = "prettierd",
          args = {},
        },
        eslint_d = {
          command = "eslint_d",
          args = { "--fix" },
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },

        -- Run Prettier first, then ESLint for fixes
        javascript = { "prettierd", "eslint_d" },
        javascriptreact = { "prettierd", "eslint_d" },
        typescript = { "prettierd", "eslint_d" },
        typescriptreact = { "prettierd", "eslint_d" },
        vue = { "prettierd", "eslint_d" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        graphql = { "prettierd" },
        handlebars = { "prettierd" },
      },
      -- Auto format on save
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
  },
}
