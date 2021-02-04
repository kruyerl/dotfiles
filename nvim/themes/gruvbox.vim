
hi Comment cterm=italic
let g:gruvbox_hide_endofbuffer=1
let onedark_terminal_italics=1
"let g:gruvbox_termcolors=16
"
let g:gruvbox_termcolors=25
syntax on
colorscheme gruvbox

" checks if your nerminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

