return {
  {
    "hrsh7th/nvim-cmp",            -- Autocomplete plugin
    "hrsh7th/cmp-nvim-lsp",        -- LSP source for cmp
    "hrsh7th/cmp-buffer",          -- Buffer source for cmp
    "hrsh7th/cmp-path",            -- Path completion
    "hrsh7th/cmp-cmdline",         -- Command line source for cmp
    "saadparwaiz1/cmp_luasnip",    -- Snippets source for cmp
    "L3MON4D3/LuaSnip",            -- Snippet engine
    config = function()
      -- nvim-cmp setup
      local cmp = require('cmp')
      cmp.setup({
        completion = { completeopt = 'menu,menuone,noinsert' },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)  -- For snippet expansion
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-u>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'luasnip' },
        },
      })
    end,
  },
}

