" text display
set nu
"set relativenumber
syntax on
set t_Co=256
set cursorline
set nowrap
set hlsearch
filetype plugin on
"set true color
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
" lightline
" let g:lightline = { 'colorscheme': 'onehalfdark' }
set background=dark

" windows
" set splitbelow
" set termwinsize=10x0

highlight SignColumn ctermbg=0

" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 25

"gotag for go language
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" color scheme
Plug 'morhetz/gruvbox'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'kyoz/purify', { 'rtp': 'vim' }

" syntax highlight for yang
Plug 'nathanalderson/yang.vim'

"=============== auto complete ===============

" --------- ctags & gtags -----------------
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
" let $GTAGSLABEL = 'default'
" let $GTAGSCONF = '/home/dyang/.globalrc'
" gutentags set the root marker file 
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" let g:gutentags_project_root = ['.root']
" the file to be created
let g:gutentags_ctags_tagfile = '.tags'
" support both ctags and gtags
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif
" place automatically-produced ctags/gtags files into ~/.cache/tags to avoid
" dirty project files
let g:gutentags_cache_dir = expand('~/.cache/tags')
" setting options of ctags, Note that it assumes it is universal-ctags instead
" of Exuberant-ctags which has not option '--extra=+q'
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" the following option is only for univeral-ctags 
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
" prevent gutentags from automatically load gtags database
" let g:gutentags_auto_add_gtags_cscope = 0
" let g:gutentags_plus_switch = 1
" let g:gutentags_define_advanced_commands = 1

"------------- outline of current file --------------------
" outline of class
Plug 'preservim/tagbar', { 'on': 'TagbarToggle' }
nmap <F8> :TagbarToggle<CR>

"-------------  YouComplteMe ---------------
" Make sure you use single quotes
" add -DCMAKE_EXPORT_COMPILE_COMMANDS=ON option to index for C-like program
Plug 'ycm-core/YouCompleteMe'
nnoremap <Leader>jd :YcmCompleter GoToDefinition<CR>
nnoremap <Leader>jr :YcmCompleter GoToReferences<CR>
nnoremap <Leader>je :YcmCompleter GoToDeclaration<CR>

"============ Syntax Check ===================="
" syntax check
" Plug 'vim-syntastic/syntastic'

Plug 'dense-analysis/ale'
" need install code linter (pylint) in venv environment"
let g:ale_disable_lsp = 1

"================= status bar ================"
" Plug 'itchyny/lightline.vim'

"--------------------------------------------
Plug 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1

Plug 'vim-airline/vim-airline-themes'
"-------------------------------------------

"================= git ======================="
Plug 'tpope/vim-fugitive'

" gitgutter
Plug 'airblade/vim-gitgutter'
let g:gitgutter_terminal_reports_forcus=0
let g:gitgutter_set_sign_backgrounds = 1

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

"===================== 	directory tree ============================
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'tpope/vim-fireplace', { 'for': 'clojure' }


" Using a non-default branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" let g:go_def_mode='gopls'
" let g:go_info_mode='gopls'

" Plugin options, it is maintenace status use vim-go instead
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

"======================== search ================================"
" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Plug 'ctrlpvim/ctrlp.vim'
"
" search text in file
Plug 'mileszs/ack.vim'

"======================== edit =================================="
Plug 'godlygeek/tabular'
Plug 'preservim/nerdcommenter'

"===================  debug ====================="
"
"Plug 'puremourning/vimspector'
"let g:vimspector_enable_mappings = 'HUMAN'
"packadd! vimspector
"syntax enable
"filetype plugin indent on


" Initialize plugin system
call plug#end()



colorscheme purify "--------------------------------- Set onedark theme
let g:airline_theme='purify'
"colorscheme onehalfdark "--------------------------------- Set onedark theme
"let g:airline_theme='onehalfdark'
hi Normal guibg=#252834 ctermbg=234 "---- Place this after you set the colorscheme
