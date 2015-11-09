"" For gvim 
if has("gui_running")
    set guifont=Liberation\ Mono\ 12
    colorscheme neon
endif

"""""""" NON PLUGIN STUFF 
"256 color mode for vom when using 256 color terminal (iTerm2)"
if $TERM == "xterm-256color" || $TERM =="screen-256color" || $COLORTERM == "gnome-terminal"
	set t_Co=256
endif
""PowerlineStuff
set laststatus=2
set encoding=utf-8
let g:Powerline_symbols = 'unicode'

"" Tab stuff"
set tabstop=4 softtabstop=2 expandtab shiftwidth=4 smarttab
syntax on
""esc is now jk 
inoremap jk      <esc>
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

let g:tex_flavor = "latex"
highlight ColorColumn ctermbg=red ctermfg=red cterm=bold term=bold



let mapleader = "|"
nmap <leader>g :call all#ToggleLineLength()<CR>

filetype plugin indent on





