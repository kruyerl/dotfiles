" === Leader Key === " 
let g:mapleader = "\<Space>"

" === Window Selection & Sizing === " 
" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>
" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" === Escape Alternatives === " 
" I hate escape more than anything else
inoremap jk <Esc>
inoremap kj <Esc>
nnoremap <C-c> <Esc>

" === Buffer Handling === " 
" Alternate way to save
nnoremap <C-s> :w<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>
" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" ????????????????????
"better nav for omnicomplete
"inoremap <expr> <c-j> ("\<C-n>")
"inoremap <expr> <c-k> ("\<C-p>")
" Better tabbing
"vnoremap < <gv
"vnoremap > >gv
"nnoremap <Leader>o o<Esc>^Da
"nnoremap <Leader>O O<Esc>^Da
" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %