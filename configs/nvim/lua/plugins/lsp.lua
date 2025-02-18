-- Completion engine
return {
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",
    opts = {
      keymap = { preset = "default" },
      signature = { enabled = true },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = {
          auto_show = true,
        },
        trigger = {
          show_on_accept_on_trigger_character = true,
          show_on_x_blocked_trigger_characters = { "'", '"', "(", "{", "[" },
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
    opts_extend = { "sources.default" },
  },
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local servers = { "lua_ls", "ts_ls", "pyright" }
      local tools = { "stylua", "prettierd", "black", "eslint_d" }
      require("mason").setup({
        ensure_installed = tools,
        automatic_installation = true,
      })
      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Set up LSP servers
      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            -- Disable formatting from the LSP to prevent conflicts with conform.nvim
            if client.name == "ts_ls" or client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = false
              client.server_capabilities.documentRangeFormattingProvider = false
            end

            -- You can add additional LSP-related functionality here if needed
          end,
        })
      end

      -- Custom diagnostic icons
      vim.diagnostic.config({
        virtual_text = {
          prefix = "⚐", -- Could be '●', '▎', 'x'
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = false,
      })

      -- Diagnostic sign icons configuration
      local signs = {
        Error = "", -- Error sign (use any icon you prefer)
        Warn = "", -- Warning sign
        Info = "", -- Info sign
        Hint = "◉", -- Hint sign
      }

      -- Apply custom sign icons for diagnostics
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- Keybindings for diagnostics
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show Diagnostic" })
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics List" })
    end,
  },
}

