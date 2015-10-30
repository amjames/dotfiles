let maplocalleader = "-"
function ToggleSpell()
    if &spell
        set nospell
    else 
        set spell
    endif
endfunction
    

function ViewMD()
    echo "compiling ..."
    silent !clear
    silent execute "!grip " . expand("%:t") . " --export  "
    silent execute "!open " . expand("%:t:r") . ".html "
    echo "Done!"
    redraw!
endfunction

nmap <localleader><space> :call ViewMD()<CR>
nmap <localleader>s :call ToggleSpell()<CR>
