"The vimrc of me is edited! "

set nocompatible              " be iMproved, required
filetype off      " required
" highlight column 80 so I can wrap code 
set colorcolumn=80
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
"MANAGES ITS SELF YAAY" 
""
"
Plugin 'scroolose/syntastic'
"syntax errors by language" 
"
Plugin 'Lokaltog/vim-powerline'
"Status line for vim windows"
"
call vundle#end()     
syntax on
filetype plugin indent on
""set spell
" To ignore plugin indent changes, instead use:
" "filetype plugin on
" "
" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" " :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line

"""""""" NON PLUGIN STUFF 
"256 color mode for vom when using 256 color terminal (iTerm2)"
if $TERM == "xterm-256color" || $TERM =="screen-256color" || $COLORTERM == "gnome-terminal"
	set t_Co=256
endif

set tabstop=4 softtabstop=2 expandtab shiftwidth=4 smarttab
 

