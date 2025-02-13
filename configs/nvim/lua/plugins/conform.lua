return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			javascript = { "prettier_d" },
			typescript = { "prettier_d" },
			go = { "gofmt" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)

		-- Keymap to manually format
		vim.keymap.set("n", "<leader>ff", function()
			require("conform").format()
		end, { desc = "Format Document" })
	end,
}
