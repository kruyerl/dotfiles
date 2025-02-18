return {
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
		{
			"<leader><space>",
			function()
				Snacks.picker.smart({
					layout = "ivy",
					show_empty = true,
					supports_live = true,
				})
			end,
			desc = "Find Files",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers({
					on_show = function()
						vim.cmd.stopinsert()
					end,
					finder = "buffers",
					format = "buffer",
					hidden = false,
					unloaded = true,
					current = true,
					sort_lastused = true,
					win = {
						input = {
							keys = {
								["d"] = "bufdelete",
							},
						},
						list = { keys = { ["d"] = "bufdelete" } },
					},
					-- In case you want to override the layout for this keymap
					layout = "ivy",
				})
			end,
			desc = "Buffers",
		},
		{
			"<leader>n",
			function()
				Snacks.picker.notifications({
					on_show = function()
						vim.cmd.stopinsert()
					end,
					finder = "snacks_notifier",
					format = "notification",
					preview = "preview",
					formatters = {
						severity = {
							level = true,
							pos = "left", -- position of the diagnostics
							icons = true, -- show severity icons
						},
					},
					confirm = "close",
					layout = "vertical",
				})
			end,
			desc = "Notification History",
		},
		{
			"<leader>fw",
			function()
				Snacks.picker.grep_word({
					on_show = function()
						vim.cmd.stopinsert()
					end,
					layout = "ivy",
				})
			end,
			desc = "Grep",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		-- Top Pickers & Explorerfals
		{
			"<leader>cs",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "Colorschemes",
		},
		{
			"<leader>xX",
			function()
				Snacks.picker.diagnostics({
					on_show = function()
						vim.cmd.stopinsert()
					end,
					finder = "diagnostics",
					layout = "ivy",
				})
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>xx",
			function()
				Snacks.picker.diagnostics_buffer({
					on_show = function()
						vim.cmd.stopinsert()
					end,
					finder = "diagnostics",
					layout = "ivy",
				})
			end,
			desc = "Buffer Diagnostics",
		},
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
	},
}
