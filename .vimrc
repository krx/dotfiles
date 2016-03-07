set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'rdnetto/YCM-Generator'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'rust-lang/rust.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on     " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin commands are not allowed.

"General vim settings
set laststatus=2 "grey status bar on bottom
syn on "turn on syntax highlighting
filetype indent on "smart indents based on filetypes
set ai "auto indents
set nu "show line numbers
set ic "case insensitive searches
set smartcase "smart case searches, defaults to ic, if has caps, use it
set incsearch "incremental search
set expandtab "change all new tabs to spaces
set tabstop=4 "tabs set to 4 spaces
set shiftwidth=4 "indents also 4 spaces
set shiftround "indent rount to next shiftwidth
set backspace=indent,eol,start "smart-er backspaces
set ww=b,s,h,l,<,>,[,] "set (b)ackspace, (s)pace, and arrows to jump lines

"Color stuff
colorscheme solarized
let g:solarized_contrast="high"
let g:solarized_termcolors=256
let g:solarized_termtrans=1
set background=dark " dark | light "
set t_Co=256
highlight LineNr ctermfg=grey ctermbg=none

"Rainbow parens stuff
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

set showmode
filetype plugin on
nnoremap <leader>t :NERDTreeToggle<CR>

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

set rtp+=/usr/lib/python2.7/dist-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2
"set showtabline=2
" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
