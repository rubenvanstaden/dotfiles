" Set encoding
set encoding=utf-8

" Enable syntax highlighting
syntax enable

" Enable line numbering
set number

" Enable smart indentation
set smartindent

" Set tab width to 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Enable auto-indentation
set autoindent

" Enable search highlighting
set hlsearch

" Enable incremental search
set incsearch

" Enable mouse support
set mouse=a

" Set a simple statusline
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]

" Save and restore cursor position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
