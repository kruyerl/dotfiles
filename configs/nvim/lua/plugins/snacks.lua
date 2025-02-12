return{
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    animate = { enabled = true },
    lazygit = { enabled = true },
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    -- Top Pickers & Explorer
    { "<leader>ff", function() Snacks.picker.smart({layout = "ivy"}) end, desc = "Smart Find Files" },
    { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
    -- Top Pickers & Explorer
    -- { "<leader>xX", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    -- { "<leader>xx", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    -- { "<leader>m", function() Snacks.picker.run({ cmd = "Copilot panel" }) end, mode = { "n" }, desc = "Copilot Panel in Snacks Picker" },
    {
      "<leader><leader>",
      desc = "description",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        })
      end,
    }
  }
}
