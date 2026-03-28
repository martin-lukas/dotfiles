set nocompatible          " disable Vi compatibility mode, enabling full Vim features
syntax enable             " enable syntax highlighting
filetype plugin indent on " enable filetype detection, plugins, and indentation
set number                " show line numbers
set scrolloff=5           " keep 5 lines visible above/below the cursor when scrolling
set tabstop=4             " tab character displays as 4 spaces wide
set shiftwidth=4          " indent/dedent by 4 spaces with >> and <<
set expandtab             " insert spaces instead of tab characters
set autoindent            " copy indent from current line when starting a new line
set ignorecase            " case-insensitive search by default
set hidden                " allow switching buffers without saving first

set laststatus=2          " always show the status bar (file name, position, etc.)
set termguicolors         " use 24-bit RGB colors if the terminal supports it
set clipboard=unnamed     " use system clipboard for yank/paste by default

highlight LineNr ctermfg=gray guifg=gray

" When reopening a file, jump to the last position the cursor was at
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \     exe "normal! g`\"" |
  \ endif

" Machine-specific overrides (not tracked in git)
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
