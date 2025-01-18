call plug#begin()

Plug 'vim-python/python-syntax'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

call plug#end()

set number
set relativenumber
set ruler
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set backspace=indent,eol,start

set termguicolors
colorscheme catppuccin_mocha

let mapleader = " "
nnoremap <leader>b :ls<CR>:b<Space>

" If the file was opened before, jump to the last viewed/edited line in it.
if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

