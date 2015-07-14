"Vimrc for herbert"


set nocompatible              " be iMproved, required
filetype off      " required
" highlight column 80 so I can wrap code 
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'scroolose/syntastic'
Plugin 'Lokaltog/vim-powerline'
call vundle#end()     
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
""PowerlineStuff
set laststatus=2
set encoding=utf-8
let g:Powerline_symbols = 'fancy'

"" Tab stuff"
set tabstop=4 softtabstop=2 expandtab shiftwidth=4 smarttab
syntax on
filetype plugin indent on
""esc is now jk 
inoremap ii      <esc> 
inoremap <esc>   <nop>
""No arrow keys 
inoremap <Up>    <nop>
inoremap <Down>  <nop>
inoremap <Left>  <nop>
inoremap <Right> <nop>
noremap  <Up>    <nop>
noremap  <Down>  <nop>
noremap  <Left>  <nop>
noremap  <Right> <nop>

map - dd p 
map _ dd k P
""Hilight column 80 if cc exitis
if exists('+colorcolumn')
  set colorcolumn=80 
else "" if not use the hard way 
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif
