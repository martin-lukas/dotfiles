" ----- Plugins ----- "
" (takes care of syntax and filetype detection)
call plug#begin()
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
call plug#end()

" ----- Settings ----- "
language en_US.UTF-8
set nocompatible
set number
set scrolloff=5
set ruler
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set ignorecase
" treat numbers with leading 0 as decimals
set nrformats=
set splitbelow
set splitright
set hidden


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


" Create a command for custom run configuration
function! SetRunCmd(cmd)
      execute 'noremap <Leader>r :w<CR>:term ' . a:cmd . '<CR>'
endfunction

command! -nargs=1 RunCmd call SetRunCmd(<q-args>)

