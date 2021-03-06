set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-sensible'

Plugin 'scrooloose/nerdtree'

Plugin 'scrooloose/nerdcommenter'

Plugin 'vim-airline/vim-airline'

Plugin 'fatih/vim-go'

Plugin 'vim-syntastic/syntastic'

Plugin 'StanAngeloff/php.vim'

Plugin 'vim-jp/vim-cpp'

" Autocomplete for golang
Plugin 'nsf/gocode', {'rtp': 'vim/'}

"Bundle 'Shougo/vimproc'
"Bundle 'Shougo/unite.vim'
"Bundle 'm2mdas/phpcomplete-extended'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Enable colors
syntax on

map <C-n> :NERDTreeToggle<CR>
map <C-r> :NERDTreeFind<CR>

let g:php_syntax_extensions_enabled = ['core', 'curl']

" Show line numbers
set number 

" Enable scrolling
set mouse=a

set shiftwidth=4 "sets number of indentation spaces
set tabstop=4 "sets number of tab spaces
set hidden "remembers undo after saving file

set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn,.git,*/vendor/*
