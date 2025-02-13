return {
	"mfussenegger/nvim-lint",
	dependencies = {
		"williamboman/mason.nvim",
	},
	config = function()
		require("mason").setup({
			ensure_installed = {
				"ruff",
				"luacheck",
				"eslint_d",
				"golangci-lint",
				"markdownlint",
			},
		})
		require("lint").linters_by_ft = {
			python = { "ruff" },
			lua = { "luacheck" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			go = { "golangci-lint" },
			markdown = { "markdownlint" },
		}

		-- Auto-run linter on save
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
