let maplocalleader = "-"
function ToggleSpell()
    if &spell
        set nospell
    else 
        set spell
    endif
endfunction
    

function CompilePdf()
    echo "compiling ..."
    silent !clear
    silent execute "!maketex " . expand("%:t")
    echo "Done!"
    redraw!
endfunction

function CleanDir()
    echo "clean up!"
    silent execute "!maketex clean"
    redraw!
endfunction

nmap <localleader><space> :call CompilePdf()<CR>
nmap <localleader><bs> :call CleanDir()<CR>
nmap <localleader>s :call ToggleSpell()<CR>
