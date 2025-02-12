return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" }, -- Optional snippets

    version = "*",
    opts = {
      keymap = { preset = "super-tab" },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      signature = { enabled = true },
      sources = {
        -- add lazydev to your completion providers
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {

          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      }
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Initialize mason
      require("mason").setup()

      -- Ensure LSP servers are installed automatically
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "tsserver", "pyright" },
        automatic_installation = true,
      })
      local lspconfig = require("lspconfig")

      -- Set up individual LSP servers
      lspconfig.lua_ls.setup({
        on_attach = function(client, bufnr)
          -- Keybindings or other LSP configuration can go here
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
        end,
      })
      lspconfig.tsserver.setup({
        on_attach = function(client, bufnr)
          -- Example keybinding for tsserver
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
        end,
      })
      lspconfig.pyright.setup({
        on_attach = function(client, bufnr)
          -- Example keybinding for pyright
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
        end,
      })


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
        Error = "",    -- Error sign (use any icon you prefer)
        Warn = "",     -- Warning sign
        Info = "",     -- Info sign
        Hint = "◉",     -- Hint sign
      }

      -- Apply custom sign icons for diagnostics
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
  }
}

