call plug#begin()

Plug 'vim-python/python-syntax'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

call plug#end()

set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

set termguicolors
colorscheme catppuccin_mocha

let mapleader = " "
set showcmd

