return {
  {
    "github/copilot.vim",
    config = function()
      vim.keymap.set("n", "<leader>gp", "<cmd>Copilot panel<CR>")
    end
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      {"github/copilot.vim"},
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = function()
      vim.keymap.set("n", "<leader>gc", "<cmd>CopilotChatToggle<CR>") -- Toggle the chat
    end,
  },
}

