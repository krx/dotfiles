set nocompatible
set encoding=utf-8

" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

" vim-plug setup {{{
call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe'
Plug 'kien/rainbow_parentheses.vim'
Plug 'rdnetto/YCM-Generator'
Plug 'altercation/vim-colors-solarized'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'yggdroot/indentline'
Plug 'ctrlpvim/ctrlp.vim'

call plug#end()
" }}}

" Airline config {{{
set laststatus=2
set noshowmode
let g:airline_powerline_fonts = 1

" Get rid of that weird android menu looking thing
let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])

" Fuck this
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_left_alt_sep = '|'
let g:airline_right_alt_sep = '|'

" Disable the trailing whitespace section
let g:airline#extensions#whitespace#enabled = 0
" }}}

" Theme {{{
colorscheme gruvbox
set guifont=Input:h14
let g:gruvbox_contrast_dark="soft"
set termguicolors
set background=dark " dark | light "
set t_Co=256
"highlight LineNr ctermfg=grey ctermbg=none
" }}}

" General settings {{{
let mapleader = "," " Closer leader key
set hidden
filetype indent on " smart indents based on filetypes
" tabs n stuff
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent " always set autoindenting on"
set copyindent " copy the previous indentation on autoindenting
set visualbell t_vb=     " don't beep
set noerrorbells         " don't beep
set ww=b,s,h,l,<,>,[,] " set (b)ackspace, (s)pace, and arrows to jump lines
set cursorline " highlight the current line
set number " line numbers

" Search settings
" Make regex behave normally
nnoremap / /\v
vnoremap / /\v
set gdefault
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
"set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

" Quickly clear search
noremap <leader><space> :noh<cr>

" Quicker jump to matching paren etc.
nnoremap <tab> %
vnoremap <tab> %
set clipboard=unnamed " normal OS clipboard interaction

" Fullscreen in OS X
if has("gui_macvim")
    set fu
endif
" }}}

" NERDTree settings {{{
nnoremap <leader>t :NERDTreeToggle<CR>

" Store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Show hidden files, too
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1

" Quit if NERDTree is the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Highlight the selected entry in the tree
let NERDTreeHighlightCursorline=1

" Use a single click to fold/unfold directories and a double click to open
" files
let NERDTreeMouseMode=2

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
            \ '\.o$', '\.so$', '\.egg$', '^\.git$', '__pycache__', '\.DS_Store' ]

" }}}

" Rainbow Parens {{{
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" }}}

" Quick vimrc access {{{
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
" }}}

" Fiiiiiine
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

" For moving over wrapped lines
nnoremap j gj
nnoremap k gk
set pastetoggle=<F2>

" Bit faster
nnoremap ; :

" Save on losing focus
au FocusLost * :wa

" Improving split window usage
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" For scrolling at least
set mouse=a

" Just write damn it
cnoremap w!! w !sudo tee % >/dev/null

" Avoid accidental hits of <F1> while aiming for <Esc>
noremap! <F1> <Esc>

" Quick yanking to the end of the line
nnoremap Y y$

" Folding
set foldmethod=marker
nnoremap <Space> za
vnoremap <Space> za

let g:flake8_show_in_gutter=1

" Show help in a vertical split
autocmd FileType help wincmd L

" C-s to save from n/i
nnoremap <c-s> :w<CR>
inoremap <c-s> <c-o>:w<CR>

