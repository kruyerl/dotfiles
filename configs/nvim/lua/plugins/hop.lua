return {
	{
		"wsdjeg/hop.nvim",
		version = "*",
		opts = {
			keys = "etovxqpdygfblzhckisuran",
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("hop").hint_char1()
				end,
				desc = "Hop Char",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("hop").hint_words()
				end,
				desc = "Hop Word",
			},
			{
				"r",
				mode = "o",
				function()
					require("hop").hint_char1()
				end,
				desc = "Hop Remote",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("hop").hint_lines()
				end,
				desc = "Hop Line",
			},
		},
	},
}
