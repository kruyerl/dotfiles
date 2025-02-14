return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs_staged_enable = true,
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				follow_files = true,
			},
			current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
				virt_text_priority = 100,
				use_focus = true,
			},
			current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
			max_file_length = 40000, -- Disable if file is longer than this (in lines)
			preview_config = {
				-- Options passed to nvim_open_win
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
		},
	},
	{ -- Core GitHub Copilot Setup

		"zbirenbaum/copilot.lua",
		cmd = "Copilot",

		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true,
					auto_refresh = true,
					keymap = {
						jump_prev = "<C-k>",
						jump_next = "<C-j>",
						accept = "<Tab>",
						refresh = "gr",
						open = "<S-Tab>",
					},
					layout = {
						position = "bottom", -- | top | left | right | horizontal | vertical
						ratio = 0.4,
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = false,
					hide_during_completion = true,
					debounce = 75,
					keymap = {
						accept = "<C-l>",
						accept_word = false,
						accept_line = false,
						next = "<C-j>",
						prev = "<C-k>",
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
			{ "<leader>gs", "<Plug>(copilot-suggest)<CR>", mode = { "n" }, desc = "Toggle Copilot Chat" },
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
