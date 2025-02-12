return{
	{
		'stevearc/oil.nvim',
		opts = {},
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		lazy = false,
    keys = {
          { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    },
	}
}
