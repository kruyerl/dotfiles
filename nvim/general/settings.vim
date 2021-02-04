" === Editor settings === " 
set termguicolors
set t_Co=256
set fileencoding=utf-8
set encoding=utf-8
set updatetime=300
set timeoutlen=500
set background=dark
set clipboard+=unnamedplus
set hidden
set splitbelow
set splitright
set mouse=a
set iskeyword+=-
syntax enable 

" === UI settings === " 
set signcolumn=yes
set ruler
set nowrap
set cursorline
set showtabline=2
"set number
"set relativenumber
set colorcolumn=80
set scrolloff=8
set noshowmode
set pumheight=10
set cmdheight=1
set fillchars+=vert:.

" === TAB/Space settings === "
set tabstop=4                           
set softtabstop=4
set shiftwidth=4            
set smarttab                 
set expandtab                          
set smartindent                         
set autoindent                          

" === History settings === "
set nobackup
set nowritebackup
set autochdir
set noswapfile
set nu
set undodir=~/.vim/undodir
set undofile

" === Search settings === "
set ignorecase
set smartcase
set autoread
set incsearch
set nohlsearch

" Don't show lasts
set noshowcmd
set laststatus=0