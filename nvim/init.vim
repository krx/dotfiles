set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Attempt to save and run
nnoremap <F10>      :w<CR>:terminal clear; ./%<CR>
inoremap <F10> <Esc>:w<CR>:terminal clear; ./%<CR>
autocmd TermOpen * startinsert
