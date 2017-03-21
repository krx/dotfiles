set nocompatible
set encoding=utf-8

" vim-plug setup {{{
" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

" Autocomplete {{{
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/echodoc.vim'
"}}}
" Pretty stuff {{{
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'yggdroot/indentline'
Plug 'lilydjwg/colorizer'
" }}}
" Quick Nav {{{
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/fzf.vim'
" }}}
" Code Helpers {{{
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'ntpeters/vim-better-whitespace'
" }}}
" 'HUD' {{{
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
" }}}
" Langs {{{
Plug 'neovimhaskell/haskell-vim'
Plug 'smancill/conky-syntax.vim'
" }}}

call plug#end()
" }}}
" General settings {{{
" Closer leader key
let mapleader = " "

" Quick vimrc access {{{
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
" }}}
" Navigation {{{
" Set (b)ackspace, (s)pace, and arrows to jump lines
set ww=b,s,h,l,<,>,[,]

" Quicker jump to matching paren etc.
nnoremap <tab> %
vnoremap <tab> %
" }}}
" tabs n stuff {{{
filetype indent on " smart indents based on filetypes
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent         " always set autoindenting on
set copyindent         " copy the previous indentation on autoindenting
set visualbell t_vb=   " don't beep
set noerrorbells       " don't beep
set cursorline         " highlight the current line
" }}}
" line numbers {{{
set number
set relativenumber
" }}}
" Search settings {{{
set magic
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
"set nohlsearch      " highlight search terms
set incsearch     " show search matches as you type

" Make regex behave normally
nnoremap / /\v
vnoremap / /\v
cnoremap s/ s/\v
cnoremap %s/ %s/\v

" Quickly clear search
"noremap <leader><space> :noh<cr>
" }}}
" Folding {{{
set foldmethod=marker
nnoremap <leader><Space> za
vnoremap <leader><Space> za
" }}}
" Misc keybindings {{{
set pastetoggle=<F2>

" For moving over wrapped lines
nnoremap j gj
nnoremap k gk
nnoremap <down> j
nnoremap <up>   k

nnoremap H 0
nnoremap L $
nnoremap J 5j
nnoremap K 5k
nnoremap <S-Down> 5j
nnoremap <S-UP>   5k
vnoremap H 0
vnoremap L $
vnoremap J 5j
vnoremap K 5k
vnoremap <S-Down> 5j
vnoremap <S-UP>   5k

" Improving split window usage
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Avoid accidental hits of <F1> while aiming for <Esc>
noremap! <F1> <Esc>

" Quick yanking to the end of the line
nnoremap Y y$

" C-s to save from n/i
nnoremap <c-s>      :w<CR>
inoremap <c-s> <Esc>:w<CR>

" Attempt to save and run
nnoremap <F10>      :w<CR>:!clear; ./%<CR>
inoremap <F10> <Esc>:w<CR>:!clear; ./%<CR>

" Bit faster
nnoremap ; :
vnoremap ; :


" Keep selections when indenting
vmap < <gv
vmap > >gv

" Delete a line from insert
inoremap <C-x> <C-o>dd

" Buffer shorcuts
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

nnoremap <leader>bl :buffers<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>.  :bnext<CR>
nnoremap <leader>,  :bprev<CR>

" FZF "CtrlP"
nnoremap <C-p> :execute system('git rev-parse --is-inside-work-tree') =~ 'true' ? 'GFiles' : 'Files'<CR>
nnoremap <C-t> :BTags<CR>

" Nice when running stuff
"cnoremap ! !clear;<Space>

" }}}
" Auto stuff {{{
" Strip trailing whitespace
autocmd BufEnter * EnableStripWhitespaceOnSave

" Save on losing focus
au FocusLost * <Esc>:wa

" Show help in a vertical split
autocmd FileType help wincmd L

" Auto-shebang
augroup Shebang
  autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python2\<nl>\"|$
  autocmd BufNewFile *.rb 0put =\"#!/usr/bin/env ruby\<nl>\"|$
  autocmd BufNewFile *.sh 0put =\"#!/usr/bin/env bash\<nl>\"|$
augroup END
" }}}
" Misc {{{
set hidden
set formatoptions-=crv " Disable comment continuing to next line
set clipboard=unnamed " normal OS clipboard interaction
set mouse=a " For scrolling at least

" Fullscreen in OS X
if has("gui_macvim")
    set fu
endif

" Just write damn it
cnoremap w!! w !sudo tee % >/dev/null
" }}}

" }}}
" Airline config {{{
set laststatus=2
set noshowmode
let g:airline_powerline_fonts = 1

" Get rid of that weird android menu looking thing
"let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])

" Fuck this
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_left_alt_sep = '|'
let g:airline_right_alt_sep = '|'

 "Disable the trailing whitespace section
let g:airline#extensions#whitespace#enabled = 0

" Tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
" }}}
" Theme {{{
colorscheme gruvbox
set guifont=Input:h14
let g:gruvbox_contrast_dark="medium"
set termguicolors
set background=dark " dark | light "
set t_Co=256
"highlight LineNr ctermfg=grey ctermbg=none
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
"let g:rbpt_max = 16
"let g:rbpt_loadcmd_toggle = 0
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let g:rainbow#blacklist = [248, 250, 223, 229]
au VimEnter * :RainbowParentheses
"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces
" }}}
" neocomplete {{{
let g:echodoc_enable_at_startup = 1
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#auto_completion_start_length = 1
let g:neocomplete#enable_auto_close_preview=1

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

" This is actually C-Space
inoremap <expr><NUL>  pumvisible() ? "\<C-n>" : neocomplete#start_manual_complete()

inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" Fixes for neocomplete + multiple_cursors {{{
function! Multiple_cursors_before()
    exe 'NeoCompleteLock'
    echo 'Disabled autocomplete'
endfunction

function! Multiple_cursors_after()
    exe 'NeoCompleteUnlock'
    echo 'Enabled autocomplete'
endfunction
" }}}

" }}}
" Misc plugin settings {{{
let g:flake8_show_in_gutter=1
syn match pythonBoolean "\(\W\|^\)\zsself\ze\."

" haskell indenting
let g:haskell_indent_disable = 1

let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" }}}
