return{
    { 'nvim-mini/mini.nvim', version = false,
 config = function()
     require('mini.starter').setup({})
     require('mini.statusline').setup({})
     require('mini.tabline').setup({})
 end
},
}
