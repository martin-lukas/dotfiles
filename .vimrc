" Initialize Vim Plug (takes care of syntax and filetype detection)
call plug#begin()
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'tpope/vim-sensible' " Sensible defaults (backspace, incsearch, scrolloff, autoread, % impr.)
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-python/python-syntax'
call plug#end()

" Mappings
let mapleader = " "
nnoremap <C-L> :nohlsearch<CR><C-L>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <Leader>d :bd<CR>
" Newline without going into insert mode
nnoremap <silent> <Leader>o :put =''<CR>
nnoremap <silent> <Leader>O :put! =''<CR>

" Settings
set nocompatible
set number
set relativenumber
set ruler
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set hlsearch

" If the file was opened before, jump to the last viewed/edited line in it.
if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" Theme setting should go to the end, to avoid errors
set termguicolors
colorscheme catppuccin_mocha

