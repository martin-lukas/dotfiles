" ----- Plugins ----- "
" (takes care of syntax and filetype detection)
call plug#begin()
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'tpope/vim-sensible' " Sensible defaults (backspace, incsearch, autoread, % impr.)
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-python/python-syntax'
call plug#end()


" ----- Mappings ----- "
let mapleader = " "
noremap <C-L> :nohlsearch<CR><C-L>
noremap <Leader>b :ls<CR>:b<Space>
noremap <Leader>d :bd<CR>
noremap <Leader>q :q<CR>
noremap <Leader>w :w<CR>


" ----- Settings ----- "
language en_US.UTF-8
set nocompatible
set number
set relativenumber
set scrolloff=5
set ruler
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set hlsearch
set colorcolumn=100


" ----- Theme ----- "
" (theme setting should go to the end, to avoid errors)
" Option 2 means always visible
set laststatus=2
set statusline=%f\ %h%w%m%r\ %=%(%l:%c%V\ %=\ %P%)
set termguicolors
colorscheme catppuccin_mocha


" If the file was opened before, jump to the last viewed/edited line in it.
if has("autocmd")
  autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \     exe "normal! g`\"" |
      \ endif
endif
