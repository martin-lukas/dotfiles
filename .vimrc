set nocompatible
set number
set scrolloff=5
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set ignorecase
set hidden

set laststatus=2
set termguicolors

" If the file was opened before, jump to the last viewed/edited line in it.
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \     exe "normal! g`\"" |
  \ endif

