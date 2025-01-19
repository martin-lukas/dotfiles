" Initialize Vim Plug
call plug#begin()
Plug 'vim-python/python-syntax'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
call plug#end()

" Mappings
let mapleader = " "
nnoremap <C-L> :nohlsearch<CR><C-L>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <Leader>d :bd<CR>

" Settings
set termguicolors
colorscheme catppuccin_mocha
set number
set relativenumber
set ruler
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set backspace=indent,eol,start
set hlsearch
set incsearch

" If the file was opened before, jump to the last viewed/edited line in it.
if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

