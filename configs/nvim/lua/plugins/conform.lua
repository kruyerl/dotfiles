return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>gf",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			javascript = { "biome", "prettier", stop_after_first = true },
			javascriptreact = { "biome", "prettier", stop_after_first = true },
			typescript = { "biome", "prettier", stop_after_first = true },
			typescriptreact = { "biome", "prettier", stop_after_first = true },
			json = { "biome", "prettier", stop_after_first = true },
			css = { "prettier" },
			scss = { "prettier" },
			html = { "prettier" },
			go = { "gopls" },
			c = { "clangd" },
			cpp = { "clangd" },
			h = { "clangd" },
			hpp = { "clangd" },
		},
		format_on_save = {
			timeout_ms = 2000,
			lsp_fallback = true,
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
