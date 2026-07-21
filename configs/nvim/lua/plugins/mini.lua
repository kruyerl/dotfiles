return {
	{ "nvim-mini/mini.nvim", version = false },
	-- Starter Screen
	{
		"nvim-mini/mini.starter",
		config = function()
			require("mini.starter").setup({})
		end,
	},
	-- Top Buffer Tab
	-- { 'nvim-mini/mini.tabline',
	--     config = function()
	--         require('mini.tabline').setup({})
	--     end
	-- },
	-- File explorer (this works properly with oil unlike nvim-tree)
	{
		"nvim-mini/mini.files",
		config = function()
			local MiniFiles = require("mini.files")
			MiniFiles.setup({
				mappings = {
					go_in = "<CR>", -- Map both Enter and L to enter directories or open files
					go_in_plus = "L",
					go_out = "_",
					go_out_plus = "H",
				},
			})
			vim.keymap.set("n", "<leader>ee", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" }) -- toggle file explorer
			vim.keymap.set("n", "<leader>ef", function()
				MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
				MiniFiles.reveal_cwd()
			end, { desc = "Toggle into currently opened file" })
		end,
	},
	-- Surround
	{
		"nvim-mini/mini.surround",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			custom_surroundings = nil,
			-- INFO:
			-- saiw surround with no whitespace
			-- saw surround with whitespace
			mappings = {
				add = "sa", -- Add surrounding in Normal and Visual modes
				delete = "ds", -- Delete surrounding
				find = "sf", -- Find surrounding (to the right)
				find_left = "sF", -- Find surrounding (to the left)
				highlight = "sh", -- Highlight surrounding
				replace = "ca", -- Replace surrounding
				update_n_lines = "sn", -- Update `n_lines`

				suffix_last = "l", -- Suffix to search with "prev" method
				suffix_next = "n", -- Suffix to search with "next" method
			},
		},
	},
	-- Get rid of whitespace
	{
		"nvim-mini/mini.trailspace",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local miniTrailspace = require("mini.trailspace")

			miniTrailspace.setup({
				only_in_normal_buffers = true,
			})
			vim.keymap.set("n", "<leader>cw", function()
				miniTrailspace.trim()
			end, { desc = "Erase Whitespace" })

			-- Ensure highlight never reappears by removing it on CursorMoved
			vim.api.nvim_create_autocmd("CursorMoved", {
				pattern = "*",
				callback = function()
					require("mini.trailspace").unhighlight()
				end,
			})
		end,
	},
	-- Split & join
	{
		"nvim-mini/mini.splitjoin",
		config = function()
			local miniSplitJoin = require("mini.splitjoin")
			miniSplitJoin.setup({
				mappings = { toggle = "" }, -- Disable default mapping
			})
			vim.keymap.set({ "n", "x" }, "sj", function()
				miniSplitJoin.join()
			end, { desc = "Join arguments" })
			vim.keymap.set({ "n", "x" }, "sk", function()
				miniSplitJoin.split()
			end, { desc = "Split arguments" })
		end,
	},
	-- Mini Jump2d
	{
		"nvim-mini/mini.jump2d",
		config = function()
			local miniJump2d = require("mini.jump2d")

			miniJump2d.setup({
				allowed_lines = { cursor_before = true },
				allowed_windows = { not_current = true },
			})

			-- vim.keymap.set("n", "<leader>j", function() miniJump2d.start() end, { desc = "Jump2d" })
		end,
	},
	-- Mini Notify
	{
		"nvim-mini/mini.notify",
		config = function()
			require("mini.notify").setup({
				content = {
					format = function(notif)
						return notif.msg
					end,
				},
				window = {
					config = function()
						return {
							title = "",
							anchor = "SE",
							row = vim.o.lines - 3,
							-- col = vim.o.columns,
							border = "rounded",
						}
					end,
				},
			})
		end,
	},
}
