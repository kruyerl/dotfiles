return {
  { -- Core GitHub Copilot Setup
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require('copilot').setup({
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_prev = "kk",
            jump_next = "jj",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>"
          },
          layout = {
            position = "bottom", -- | top | left | right | horizontal | vertical
            ratio = 0.4
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            accept = "<C-l>",
            accept_word = false,
            accept_line = false,
            next = "]]",
            prev = "[[",
            dismiss = "<Esc>",
          },
        },
        filetypes = {
          markdown = true,
        },
      })
    end,
    keys = {
      { "<leader>gp", "<cmd>Copilot panel<CR>", mode = { "n" }, desc = "Toggle Copilot Chat" },
    },
  },

  { -- Copilot LSP Completion for nvim-cmp
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  { -- Copilot Chat (Optional)
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {},
    keys = {
      { "<leader>gc", "<cmd>CopilotChatToggle<CR>", mode = { "n" }, desc = "Toggle Copilot Chat" },
    },
  },
}

