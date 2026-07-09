return {
    "nvim-lua/plenary.nvim", --  multiple plugins need
    -- fixes undefined globals
    {
        "folke/lazydev.nvim",
        lazy = "VeryLazy",
        priority = 1000,
        opts = {
            library = {
                {
                    path = "${3rd}/plenary.nvim/lua",
                    words = { "plenary" }
                },
                { path = "LazyVim" },
            },
        },
    },
}
