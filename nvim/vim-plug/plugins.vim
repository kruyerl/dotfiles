" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif


call plug#begin('~/.config/nvim/autoload/plugged')

" === Editing Plugins === "
	" Trailing whitespace highlighting & automatic fixing
	Plug 'ntpeters/vim-better-whitespace'

	" auto-close plugin
	Plug 'rstacruz/vim-closer'

	" Improved motion in Vim
	Plug 'easymotion/vim-easymotion'

	" Intellisense Engine
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	" Denite - Fuzzy finding, buffer management
	"Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'airblade/vim-rooter'

	" Snippet support
	Plug 'Shougo/neosnippet'
	Plug 'Shougo/neosnippet-snippets'

	" Print function signatures in echo area
	Plug 'Shougo/echodoc.vim'

	"Which key - so I dont forget my shit
	Plug 'liuchengxu/vim-which-key'
	
	" Comments
	Plug 'tpope/vim-commentary'
	
" === Javascript Plugins === "
	" Typescript syntax highlighting
	Plug 'HerringtonDarkholme/yats.vim'

	" ReactJS JSX syntax highlighting
	Plug 'mxw/vim-jsx'

	" Generate JSDoc commands based on function signature
	Plug 'heavenshell/vim-jsdoc'
		
" === Syntax Highlighting === "
	" Better Syntax Support
    Plug 'sheerun/vim-polyglot'

	" Syntax highlighting for javascript libraries
	Plug 'othree/javascript-libraries-syntax.vim'
 
	" Improved syntax highlighting and indentation
	Plug 'othree/yajs.vim'

" === UI === "

	 "Colorscheme
	Plug 'morhetz/gruvbox'
	
	" Customized vim status line
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	" Icons
	"Plug 'ryanoasis/vim-devicons'

    "Plug 'jiangmiao/auto-pairs'
	
	" === Git Plugins === "
	" Enable git changes to be shown in sign column
	Plug 'mhinz/vim-signify'
	Plug 'tpope/vim-fugitive'

call plug#end()


" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif